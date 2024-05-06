import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shuttle/src/features/chat/data/models/chat_status_model.dart';
import 'package:shuttle/src/firebase_backend/common_tasks.dart';
import 'package:shuttle/src/firebase_backend/constants.dart';
import '../../exceptions_and_failures/exceptions/auth_and_user_exceptions.dart';
import '../../features/auth_and_user/data/data_sources/auth_and_user_remote_data_source.dart';
import '../../features/auth_and_user/data/models/user_model.dart';
import '../firebase_initialize.dart';

class AuthAndUserRemoteDataSourceImplementation
    implements AuthAndUserRemoteDataSource {
  const AuthAndUserRemoteDataSourceImplementation(
      {required FirebaseInitSingleton firebaseInitSingleton})
      : _firebaseInitSingleton = firebaseInitSingleton;
  final FirebaseInitSingleton _firebaseInitSingleton;

  @override
  Future<void> userSignUp({required UserModel userModel}) async {
    late final UserCredential userCred;
    try {
      userCred = await _firebaseInitSingleton.firebaseAuth
          .createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password!);
      await userCred.user?.updateDisplayName(userModel.name);
      if (userCred.user != null) {
        final userId = userCred.user!.uid;
        if (userModel.profileImageUrl != null) {
          userModel = userModel.copyWith(
              id: userId,
              profileImageUrl: await uploadProfilePic(
                  filePath: userModel.profileImageUrl!,
                  userId: userId,
                  firebaseInitSingleton: _firebaseInitSingleton));
          await userCred.user?.updatePhotoURL(userModel.profileImageUrl);
        } else {
          userModel = userModel.copyWith(
            id: userId,
          );
        }

        final userToDatabase = userModel.toMap();
        userToDatabase.remove('password');

        await _firebaseInitSingleton.firebaseFirestore
            .collection(FirebaseConstants.users)
            .doc(userId)
            .set(userToDatabase);
        await _firebaseInitSingleton.firebaseFirestore
            .collection(FirebaseConstants.users)
            .doc(userId)
            .collection(FirebaseConstants.chatStatus)
            .doc(FirebaseConstants.chatStatus)
            .set(const ChatStatusModel(isOnline: false, typingUser: null)
                .toMap());
      }
    } on FirebaseAuthException catch (e) {
      await deleteUserInCaseOfSignUpError(user: userCred.user);
      if (e.code == 'weak-password') {
        throw const WeakPasswordException(message: 'Weak Password');
      } else if (e.code == 'email-already-in-use') {
        throw const EmailAlreadyExistsException(
            message: 'Email Already Exists');
      } else if (e.code == 'invalid-email') {
        throw const InvalidEmailException(message: 'Invalid Email');
      } else {
        await deleteUserInCaseOfSignUpError(user: userCred.user);
        throw UnknownException(message: e.code);
      }
    } on ProfileImageUploadException {
      await deleteUserInCaseOfSignUpError(user: userCred.user);
      rethrow;
    } catch (e) {
      await deleteUserInCaseOfSignUpError(user: userCred.user);
      throw const UnknownException(message: 'Unknown Error');
    }
  }

  @override
  Future<void> userLogIn(
      {required UserLogInCredModel userLogInCredModel}) async {
    try {
      await _firebaseInitSingleton.firebaseAuth.signInWithEmailAndPassword(
        email: userLogInCredModel.email,
        password: userLogInCredModel.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw const InvalidEmailException(message: 'Invalid Email');
      } else if (e.code == 'user-not-found') {
        throw const UserNotFoundException(message: 'User Does Not Exists');
      } else if (e.code == 'wrong-password') {
        throw const WrongPasswordException(message: 'Wrong Password');
      } else {
        throw const UnknownException(message: 'Invalid Credentials');
      }
    } catch (e) {
      throw const UnknownException(message: 'Unknown Error');
    }
  }

  @override
  Future<List<UserModel>> getAllContacts() async {
    late final List<UserModel> contacts;
    try {
      final users = await _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser?.uid)
          .collection(FirebaseConstants.contacts)
          .get();
      contacts = await Future.wait(users.docs.map((data) async {
        final user = await getUserData(
            firebaseInitSingleton: _firebaseInitSingleton,
            id: data.data()['id']);
        return user;
      }).toList());
    } on FirebaseException catch (e) {
      throw ContactsException(message: e.code);
    } catch (e) {
      throw ContactsException(message: e.toString());
    }
    return contacts;
  }

  @override
  Future<bool> contactExists({required String id}) async {
    try {
      final document = _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser!.uid)
          .collection(FirebaseConstants.contacts)
          .doc(id);

      final snapshot = await document.get();

      return snapshot.exists;
    } on FirebaseException catch (e) {
      throw ContactsException(message: e.code);
    } catch (e) {
      throw ContactsException(message: e.toString());
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    late final List<UserModel> users;
    try {
      final usersRef = await _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .get();
      users = usersRef.docs
          .map((data) => UserModel.fromMap(data.data()))
          .where((element) =>
              element.id !=
              _firebaseInitSingleton.firebaseAuth.currentUser!.uid)
          .toList();
    } on FirebaseException catch (e) {
      throw ContactsException(message: e.code);
    } catch (e) {
      throw ContactsException(message: e.toString());
    }
    return users;
  }

  @override
  Future<void> addToContact({required String id}) async {
    late final DocumentReference<Map<String, dynamic>> userContact;
    late final DocumentReference<Map<String, dynamic>> otherUserContact;
    try {
      final createdDateTime = DateTime.now().toIso8601String();
      userContact = _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser!.uid)
          .collection(FirebaseConstants.contacts)
          .doc(id);
      userContact.set({
        'id': userContact.id,
        'created': createdDateTime,
      });

      otherUserContact = _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(id)
          .collection(FirebaseConstants.contacts)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser!.uid);
      otherUserContact.set({
        'id': otherUserContact.id,
        'created': createdDateTime,
      });

      await createChatIfItDoesNotExist(
          otherUserId: id, firebaseInitSingleton: _firebaseInitSingleton);
    } on FirebaseAuthException catch (e) {
      userContact.delete();
      otherUserContact.delete();
      throw AddContactException(message: e.code);
    } catch (e) {
      userContact.delete();
      otherUserContact.delete();
      throw const UnknownException(message: 'Unknown Error');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseInitSingleton.firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw LogOutException(message: e.message ?? 'Something Went Wrong');
    } catch (e) {
      throw LogOutException(message: e.toString());
    }
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../exceptions_and_failures/exceptions/auth_and_user_exceptions.dart';
import '../features/auth_and_user/data/models/user_model.dart';
import 'constants.dart';
import 'firebase_initialize.dart';

enum ContentType {
  image,
  video,
}

const Map<ContentType, String> contentTypeMap = {
  ContentType.image: "image/jpeg",
  ContentType.video: "video/mp4"
};

Future<String> uploadProfilePic(
    {required String filePath,
    required String userId,
    required FirebaseInitSingleton firebaseInitSingleton}) async {
  late final String downloadUrl;
  const uuid = Uuid();
  final getFileName = uuid.v4();
  try {
    File file = File(filePath);
    // Setting the path for upload in firebase storage.

    Reference ref = firebaseInitSingleton.firebaseStorage
        .ref()
        .child(userId)
        .child('profile_image')
        .child(getFileName);

    // Sets the task for uploading file.
    UploadTask uploadTask = ref.putFile(
        file,
        SettableMetadata(
          contentType: contentTypeMap[ContentType.image],
        ));

    TaskSnapshot snapshot = await uploadTask;
    // Gets download url of uploaded file.

    downloadUrl = await snapshot.ref.getDownloadURL();
  } catch (e) {
    throw const ProfileImageUploadException(
        message: 'Profile Image Upload Error');
  }
  return downloadUrl;
}

Future<void> deleteUserInCaseOfSignUpError({required User? user}) async {
  await user?.delete();
}

Future<UserModel> getUserData(
    {String? id, required FirebaseInitSingleton firebaseInitSingleton}) async {
  late final DocumentSnapshot<Map<String, dynamic>> userRef;
  try {
    if (id == null) {
      userRef = await firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(firebaseInitSingleton.firebaseAuth.currentUser?.uid)
          .get();
    } else {
      userRef = await firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(id)
          .get();
    }
    return UserModel.fromMap(userRef.data()!);
  } on FirebaseException {
    rethrow;
  } catch (e) {
    rethrow;
  }
}

Future<void> createChatIfItDoesNotExist(
    {required String otherUserId,
    required FirebaseInitSingleton firebaseInitSingleton}) async {
  final userId = firebaseInitSingleton.firebaseAuth.currentUser?.uid;
  final userChatRef = firebaseInitSingleton.firebaseFirestore
      .collection(FirebaseConstants.users)
      .doc(userId)
      .collection(FirebaseConstants.chats)
      .doc(otherUserId);

  final otherUserChatRef = firebaseInitSingleton.firebaseFirestore
      .collection(FirebaseConstants.users)
      .doc(otherUserId)
      .collection(FirebaseConstants.chats)
      .doc(userId);

  final userChatRefDocExists = await userChatRef.get();
  final otherUserChatRefDocExists = await otherUserChatRef.get();

  if (userChatRefDocExists.exists && otherUserChatRefDocExists.exists) {
    return;
  } else {
    userChatRef
        .set({'latest_message_timestamp': DateTime(2000).toIso8601String()});
    otherUserChatRef
        .set({'latest_message_timestamp': DateTime(2000).toIso8601String()});
  }
}

import 'package:dartz/dartz.dart';
import '../../../../exceptions_and_failures/exceptions/auth_and_user_exceptions.dart';
import '../../../../exceptions_and_failures/failures/auth_and_user_failures.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../../../../exceptions_and_failures/success/auth_and_user_success.dart';
import '../../../../exceptions_and_failures/success/success.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_and_user_repository.dart';
import '../data_sources/auth_and_user_remote_data_source.dart';
import '../models/user_model.dart';

class AuthAndUserRepoImplementation implements AuthAndUserRepository {
  const AuthAndUserRepoImplementation(
      {required AuthAndUserRemoteDataSource authAndUserRemoteDataSource})
      : _authAndUserRemoteDataSource = authAndUserRemoteDataSource;

  final AuthAndUserRemoteDataSource _authAndUserRemoteDataSource;

  @override
  Future<Either<Failure, Success>> signUp({required UserEntity user}) async {
    try {
      await _authAndUserRemoteDataSource.userSignUp(
          userModel: UserModel.mapToModelFromEntity(user));
    } on WeakPasswordException catch (e) {
      return Left(SignUpFailure(message: e.message));
    } on EmailAlreadyExistsException catch (e) {
      return Left(SignUpFailure(message: e.message));
    } on InvalidEmailException catch (e) {
      return Left(SignUpFailure(message: e.message));
    } on UnknownException catch (e) {
      return Left(SignUpFailure(message: e.message));
    } catch (e) {
      return Left(SignUpFailure(message: e.toString()));
    }
    return const Right(SignUpSuccess(message: 'Signed Up Successfully'));
  }

  @override
  Future<Either<Failure, Success>> logIn(
      {required UserLogInCredEntity userLogInCredEntity}) async {
    try {
      await _authAndUserRemoteDataSource.userLogIn(
          userLogInCredModel:
              UserLogInCredModel.mapToModelFromEntity(userLogInCredEntity));
    } on InvalidEmailException catch (e) {
      return Left(LogInFailure(message: e.message));
    } on UserNotFoundException catch (e) {
      return Left(LogInFailure(message: e.message));
    } on WrongPasswordException catch (e) {
      return Left(LogInFailure(message: e.message));
    } on UnknownException catch (e) {
      return Left(LogInFailure(message: e.message));
    } catch (e) {
      return Left(SignUpFailure(message: e.toString()));
    }
    return const Right(LogInSuccess(message: 'Logged In Successfully'));
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllContacts() async {
    late final List<UserModel> contacts;
    try {
      contacts = await _authAndUserRemoteDataSource.getAllContacts();
    } on ContactsException catch (e) {
      return Left(ContactsFailure(message: e.message));
    } catch (e) {
      return Left(ContactsFailure(message: e.toString()));
    }
    return Right(contacts);
  }

  @override
  Future<Either<Failure, bool>> contactExists({required String id}) async {
    late final bool contactExists;
    try {
      contactExists = await _authAndUserRemoteDataSource.contactExists(id: id);
    } on ContactsException catch (e) {
      return Left(ContactsFailure(message: e.message));
    } catch (e) {
      return Left(ContactsFailure(message: e.toString()));
    }
    return Right(contactExists);
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    late final List<UserModel> users;
    try {
      users = await _authAndUserRemoteDataSource.getAllUsers();
    } on ContactsException catch (e) {
      return Left(ContactsFailure(message: e.message));
    } catch (e) {
      return Left(ContactsFailure(message: e.toString()));
    }
    return Right(users);
  }

  @override
  Future<Either<Failure, Success>> addToContact({required String id}) async {
    try {
      await _authAndUserRemoteDataSource.addToContact(id: id);
    } on AddContactException catch (e) {
      return Left(AddContactFailure(message: e.message));
    } catch (e) {
      return Left(AddContactFailure(message: e.toString()));
    }
    return const Right(
        AddContactSuccess(message: 'Contact Added Successfully'));
  }

  @override
  Future<Either<Failure, Success>> logout() async {
    try {
      await _authAndUserRemoteDataSource.logout();
    } on LogOutException catch (e) {
      return Left(LogOutFailure(message: e.message));
    } catch (e) {
      return Left(LogOutFailure(message: e.toString()));
    }
    return const Right(LogOutSuccess(message: 'Logged Out Successfully'));
  }
}

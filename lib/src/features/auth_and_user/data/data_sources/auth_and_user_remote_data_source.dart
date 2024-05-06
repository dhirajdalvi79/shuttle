import '../models/user_model.dart';

abstract class AuthAndUserRemoteDataSource {
  const AuthAndUserRemoteDataSource();

  Future<void> userSignUp({required UserModel userModel});

  Future<void> userLogIn({required UserLogInCredModel userLogInCredModel});

  Future<List<UserModel>> getAllContacts();

  Future<bool> contactExists({required String id});

  Future<List<UserModel>> getAllUsers();

  Future<void> addToContact({required String id});

  Future<void> logout();
}

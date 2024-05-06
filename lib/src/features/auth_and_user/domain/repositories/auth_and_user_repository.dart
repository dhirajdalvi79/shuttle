import 'package:dartz/dartz.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../../../../exceptions_and_failures/success/success.dart';
import '../entities/user_entity.dart';

abstract class AuthAndUserRepository {
  const AuthAndUserRepository();

  Future<Either<Failure, Success>> signUp({required UserEntity user});

  Future<Either<Failure, Success>> logIn(
      {required UserLogInCredEntity userLogInCredEntity});

  Future<Either<Failure, List<UserEntity>>> getAllContacts();

  Future<Either<Failure, bool>> contactExists({required String id});

  Future<Either<Failure, List<UserEntity>>> getAllUsers();

  Future<Either<Failure, Success>> addToContact({required String id});

  Future<Either<Failure, Success>> logout();
}

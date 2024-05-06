import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../../../../exceptions_and_failures/success/success.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_and_user_repository.dart';

class LogIn extends UseCaseWithParameter<Future<Either<Failure, Success>>,
    UserLogInCredEntity> {
  const LogIn({required AuthAndUserRepository authAndUserRepository})
      : _authAndUserRepository = authAndUserRepository;
  final AuthAndUserRepository _authAndUserRepository;

  @override
  Future<Either<Failure, Success>> call(
      {required UserLogInCredEntity parameter}) {
    return _authAndUserRepository.logIn(userLogInCredEntity: parameter);
  }
}

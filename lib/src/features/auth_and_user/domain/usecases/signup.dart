import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../../../../exceptions_and_failures/success/success.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_and_user_repository.dart';

class SignUp
    extends UseCaseWithParameter<Future<Either<Failure, Success>>, UserEntity> {
  const SignUp({required AuthAndUserRepository authAndUserRepository})
      : _authAndUserRepository = authAndUserRepository;
  final AuthAndUserRepository _authAndUserRepository;

  @override
  Future<Either<Failure, Success>> call({required UserEntity parameter}) {
    return _authAndUserRepository.signUp(user: parameter);
  }
}

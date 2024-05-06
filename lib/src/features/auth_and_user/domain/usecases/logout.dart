import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../../../../exceptions_and_failures/success/success.dart';
import '../repositories/auth_and_user_repository.dart';

class LogOut extends UseCaseWithoutParameter<Future<Either<Failure, Success>>> {
  const LogOut({required AuthAndUserRepository authAndUserRepository})
      : _authAndUserRepository = authAndUserRepository;
  final AuthAndUserRepository _authAndUserRepository;

  @override
  Future<Either<Failure, Success>> call() {
    return _authAndUserRepository.logout();
  }
}

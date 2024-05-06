import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_and_user_repository.dart';

class GetAllUsers
    extends UseCaseWithoutParameter<Future<Either<Failure, List<UserEntity>>>> {
  const GetAllUsers({required AuthAndUserRepository authAndUserRepository})
      : _authAndUserRepository = authAndUserRepository;
  final AuthAndUserRepository _authAndUserRepository;

  @override
  Future<Either<Failure, List<UserEntity>>> call() {
    return _authAndUserRepository.getAllUsers();
  }
}

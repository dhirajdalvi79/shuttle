import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../repositories/auth_and_user_repository.dart';

class ContactExists
    extends UseCaseWithParameter<Future<Either<Failure, bool>>, String> {
  const ContactExists({required AuthAndUserRepository authAndUserRepository})
      : _authAndUserRepository = authAndUserRepository;
  final AuthAndUserRepository _authAndUserRepository;

  @override
  Future<Either<Failure, bool>> call({required String parameter}) {
    return _authAndUserRepository.contactExists(id: parameter);
  }
}

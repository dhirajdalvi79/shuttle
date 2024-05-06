import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../../../auth_and_user/domain/entities/user_entity.dart';
import '../repositories/chat_repository.dart';

class GetAppUser
    extends UseCaseWithParameter<Future<Either<Failure, UserEntity>>, String?> {
  const GetAppUser({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Future<Either<Failure, UserEntity>> call({String? parameter}) {
    return _chatRepository.getAppUser(id: parameter);
  }
}

import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../entities/chat_status_entity.dart';
import '../repositories/chat_repository.dart';

class GetUserChatStatus extends UseCaseWithParameter<
    Stream<Either<Failure, ChatStatusEntity>>, String> {
  const GetUserChatStatus({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Stream<Either<Failure, ChatStatusEntity>> call({required String parameter}) {
    return _chatRepository.getUserChatStatus(id: parameter);
  }
}

import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

class GetMessages extends UseCaseWithParameter<
    Stream<Either<Failure, List<MessageEntity>>>, String> {
  const GetMessages({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Stream<Either<Failure, List<MessageEntity>>> call(
      {required String parameter}) {
    return _chatRepository.getMessages(chatId: parameter);
  }
}

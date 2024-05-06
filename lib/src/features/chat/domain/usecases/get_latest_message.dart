import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

class GetLatestMessage extends UseCaseWithParameter<
    Stream<Either<Failure, MessageEntity>>, String> {
  const GetLatestMessage({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Stream<Either<Failure, MessageEntity>> call({required String parameter}) {
    return _chatRepository.getLatestMessage(chatId: parameter);
  }
}

import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../../../../exceptions_and_failures/success/success.dart';
import '../repositories/chat_repository.dart';

class DeleteMessages extends UseCaseWithParameter<
    Future<Either<Failure, Success>>, DeleteMessagesParameter> {
  const DeleteMessages({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Future<Either<Failure, Success>> call(
      {required DeleteMessagesParameter parameter}) {
    return _chatRepository.deleteMessages(
        messageIdSet: parameter.messageIdSet, chatId: parameter.chatId);
  }
}

class DeleteMessagesParameter {
  const DeleteMessagesParameter(
      {required this.messageIdSet, required this.chatId});

  final Set messageIdSet;
  final String chatId;
}

import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import 'package:shuttle/src/features/chat/domain/entities/message_entity.dart';
import 'package:shuttle/src/features/chat/domain/repositories/chat_repository.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../../../../exceptions_and_failures/success/success.dart';

class SendMessage extends UseCaseWithParameter<Future<Either<Failure, Success>>,
    SendMessageParameter> {
  const SendMessage({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Future<Either<Failure, Success>> call(
      {required SendMessageParameter parameter}) {
    return _chatRepository.sendMessage(
        messageEntity: parameter.messageEntity,
        otherUserId: parameter.otherUserId);
  }
}

class SendMessageParameter {
  const SendMessageParameter(
      {required this.messageEntity, required this.otherUserId});

  final MessageEntity messageEntity;
  final String otherUserId;
}

import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../../../../exceptions_and_failures/success/success.dart';
import '../repositories/chat_repository.dart';

class MessageStatusUpdate
    extends UseCaseWithParameter<Future<Either<Failure, Success>>, String> {
  const MessageStatusUpdate({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Future<Either<Failure, Success>> call({required String parameter}) {
    return _chatRepository.messageStatusUpdate(chatId: parameter);
  }
}

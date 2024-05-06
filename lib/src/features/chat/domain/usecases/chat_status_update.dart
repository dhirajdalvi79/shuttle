import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import 'package:shuttle/src/features/chat/domain/entities/chat_status_entity.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../../../../exceptions_and_failures/success/success.dart';
import '../repositories/chat_repository.dart';

class ChatStatusUpdate extends UseCaseWithParameter<
    Future<Either<Failure, Success>>, ChatStatusEntity> {
  const ChatStatusUpdate({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Future<Either<Failure, Success>> call({required ChatStatusEntity parameter}) {
    return _chatRepository.chatStatusUpdate(chatStatusEntity: parameter);
  }
}

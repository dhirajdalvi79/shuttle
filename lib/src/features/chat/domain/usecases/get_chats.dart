import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';

class GetChats
    extends UseCaseWithoutParameter<Stream<Either<Failure, List<ChatEntity>>>> {
  const GetChats({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Stream<Either<Failure, List<ChatEntity>>> call() {
    return _chatRepository.getChats();
  }
}

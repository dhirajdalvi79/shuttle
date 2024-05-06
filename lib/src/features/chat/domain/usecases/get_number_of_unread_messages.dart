import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../repositories/chat_repository.dart';

class GetNumberOfUnreadMessages
    extends UseCaseWithParameter<Stream<Either<Failure, int>>, String> {
  const GetNumberOfUnreadMessages({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Stream<Either<Failure, int>> call({required String parameter}) {
    return _chatRepository.getNumberOfUnreadMessages(chatId: parameter);
  }
}

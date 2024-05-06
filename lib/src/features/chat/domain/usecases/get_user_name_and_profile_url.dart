import 'package:dartz/dartz.dart';
import 'package:shuttle/src/core/usecases/usecase.dart';
import '../../../../exceptions_and_failures/failures/failures.dart';
import '../repositories/chat_repository.dart';

class GetUserNameAndProfileUrl extends UseCaseWithParameter<
    Future<Either<Failure, Map<String, String?>>>, String> {
  const GetUserNameAndProfileUrl({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Future<Either<Failure, Map<String, String?>>> call(
      {required String parameter}) {
    return _chatRepository.getUserNameAndProfileUrl(id: parameter);
  }
}

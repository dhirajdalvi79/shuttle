import 'package:dartz/dartz.dart';
import 'package:shuttle/src/exceptions_and_failures/failures/failures.dart';
import 'package:shuttle/src/exceptions_and_failures/success/success.dart';
import 'package:shuttle/src/features/auth_and_user/domain/entities/user_entity.dart';
import 'package:shuttle/src/features/chat/domain/entities/chat_status_entity.dart';
import 'package:shuttle/src/features/chat/domain/entities/message_entity.dart';
import '../entities/chat_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, Success>> sendMessage(
      {required MessageEntity messageEntity, required String otherUserId});

  Stream<Either<Failure, List<MessageEntity>>> getMessages(
      {required String chatId});

  Stream<Either<Failure, List<ChatEntity>>> getChats();

  Stream<Either<Failure, MessageEntity>> getLatestMessage(
      {required String chatId});

  Stream<Either<Failure, int>> getNumberOfUnreadMessages(
      {required String chatId});

  Future<Either<Failure, Map<String, String?>>> getUserNameAndProfileUrl(
      {required String id});

  Future<Either<Failure, UserEntity>> getAppUser({String? id});

  Future<Either<Failure, Success>> messageStatusUpdate(
      {required String chatId});

  Stream<Either<Failure, ChatStatusEntity>> getUserChatStatus(
      {required String id});

  Future<Either<Failure, Success>> chatStatusUpdate(
      {required ChatStatusEntity chatStatusEntity});

  Future<Either<Failure, Success>> deleteMessages(
      {required Set messageIdSet, required String chatId});
}

import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shuttle/src/exceptions_and_failures/exceptions/chat_exceptions.dart';
import 'package:shuttle/src/exceptions_and_failures/failures/chat_failure.dart';
import 'package:shuttle/src/exceptions_and_failures/failures/failures.dart';
import 'package:shuttle/src/exceptions_and_failures/success/chat_success.dart';
import 'package:shuttle/src/exceptions_and_failures/success/success.dart';
import 'package:shuttle/src/features/auth_and_user/data/models/user_model.dart';
import 'package:shuttle/src/features/auth_and_user/domain/entities/user_entity.dart';
import 'package:shuttle/src/features/chat/data/models/chat_status_model.dart';
import 'package:shuttle/src/features/chat/domain/entities/chat_entity.dart';
import 'package:shuttle/src/features/chat/domain/entities/chat_status_entity.dart';
import 'package:shuttle/src/features/chat/domain/entities/message_entity.dart';
import 'package:shuttle/src/features/chat/domain/repositories/chat_repository.dart';
import '../data_sources/chat_remote_data_source.dart';
import '../models/chat_models.dart';
import '../models/message_model.dart';

class ChatRepositoryImplementation implements ChatRepository {
  const ChatRepositoryImplementation(
      {required ChatRemoteDataSource chatDataSource})
      : _chatDataSource = chatDataSource;
  final ChatRemoteDataSource _chatDataSource;

  @override
  Stream<Either<Failure, List<ChatEntity>>> getChats() {
    return _chatDataSource.getChats().transform(StreamTransformer<
                List<ChatModel>,
                Either<Failure, List<ChatEntity>>>.fromHandlers(
            handleError: (error, stackTrace, sink) {
          if (error is ChatException) {
            sink.add(Left(ChatFailure(message: error.message)));
          } else {
            sink.add(Left(ChatFailure(message: error.toString())));
          }
        }, handleData: (data, sink) {
          sink.add(Right(data));
        }));
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getMessages(
      {required String chatId}) {
    return _chatDataSource.getMessages(chatId: chatId).transform(
            StreamTransformer<List<MessageModel>,
                    Either<Failure, List<MessageEntity>>>.fromHandlers(
                handleError: (error, stackTrace, sink) {
          if (error is ChatException) {
            sink.add(Left(ChatFailure(message: error.message)));
          } else {
            sink.add(Left(ChatFailure(message: error.toString())));
          }
        }, handleData: (data, sink) {
          sink.add(Right(data));
        }));
  }

  @override
  Future<Either<Failure, Success>> sendMessage(
      {required MessageEntity messageEntity,
      required String otherUserId}) async {
    try {
      await _chatDataSource.sendMessage(
          message: MessageModel.mapToModelFromEntity(messageEntity),
          otherUserId: otherUserId);
    } on ChatException catch (e) {
      return Left(ChatFailure(message: e.message));
    } catch (e) {
      return Left(ChatFailure(message: e.toString()));
    }
    return const Right(ChatSuccess(message: 'Message Sent Successfully'));
  }

  @override
  Stream<Either<Failure, MessageEntity>> getLatestMessage(
      {required String chatId}) {
    return _chatDataSource.getLatestMessage(chatId: chatId).transform(
            StreamTransformer<MessageModel,
                    Either<Failure, MessageEntity>>.fromHandlers(
                handleError: (error, stackTrace, sink) {
          if (error is ChatException) {
            sink.add(Left(ChatFailure(message: error.message)));
          } else {
            sink.add(Left(ChatFailure(message: error.toString())));
          }
        }, handleData: (data, sink) {
          sink.add(Right(data));
        }));
  }

  @override
  Stream<Either<Failure, int>> getNumberOfUnreadMessages(
      {required String chatId}) {
    return _chatDataSource.getNumberOfUnreadMessages(chatId: chatId).transform(
            StreamTransformer<int, Either<Failure, int>>.fromHandlers(
                handleError: (error, stackTrace, sink) {
          if (error is ChatException) {
            sink.add(Left(ChatFailure(message: error.message)));
          } else {
            sink.add(Left(ChatFailure(message: error.toString())));
          }
        }, handleData: (data, sink) {
          sink.add(Right(data));
        }));
  }

  @override
  Future<Either<Failure, Map<String, String?>>> getUserNameAndProfileUrl(
      {required String id}) async {
    late final Map<String, String?> user;
    try {
      user = await _chatDataSource.getUserNameAndProfileUrl(id: id);
    } on ChatException catch (e) {
      return Left(ChatFailure(message: e.message));
    } catch (e) {
      return Left(ChatFailure(message: e.toString()));
    }
    return Right(user);
  }

  @override
  Future<Either<Failure, UserEntity>> getAppUser({String? id}) async {
    late final UserModel user;
    try {
      user = await _chatDataSource.getAppUser(id: id);
    } on ChatException catch (e) {
      return Left(ChatFailure(message: e.message));
    } catch (e) {
      return Left(ChatFailure(message: e.toString()));
    }
    return Right(user);
  }

  @override
  Future<Either<Failure, Success>> messageStatusUpdate(
      {required String chatId}) async {
    try {
      await _chatDataSource.messageStatusUpdate(chatId: chatId);
    } on ChatException catch (e) {
      return Left(ChatFailure(message: e.message));
    } catch (e) {
      return Left(ChatFailure(message: e.toString()));
    }
    return const Right(
        ChatSuccess(message: 'Message Status Updated Successfully'));
  }

  @override
  Stream<Either<Failure, ChatStatusEntity>> getUserChatStatus(
      {required String id}) {
    return _chatDataSource.getUserChatStatus(id: id).transform(
            StreamTransformer<ChatStatusEntity,
                    Either<Failure, ChatStatusEntity>>.fromHandlers(
                handleError: (error, stackTrace, sink) {
          if (error is ChatException) {
            sink.add(Left(ChatFailure(message: error.message)));
          } else {
            sink.add(Left(ChatFailure(message: error.toString())));
          }
        }, handleData: (data, sink) {
          sink.add(Right(data));
        }));
  }

  @override
  Future<Either<Failure, Success>> chatStatusUpdate(
      {required ChatStatusEntity chatStatusEntity}) async {
    try {
      await _chatDataSource.chatStatusUpdate(
          chatStatusModel:
              ChatStatusModel.mapToModelFromEntity(chatStatusEntity));
    } on ChatException catch (e) {
      return Left(ChatFailure(message: e.message));
    } catch (e) {
      return Left(ChatFailure(message: e.toString()));
    }
    return const Right(
        ChatSuccess(message: 'Chat Status Updated Successfully'));
  }

  @override
  Future<Either<Failure, Success>> deleteMessages(
      {required Set messageIdSet, required String chatId}) async {
    try {
      await _chatDataSource.deleteMessages(
          messageIdSet: messageIdSet, chatId: chatId);
    } on ChatException catch (e) {
      return Left(ChatFailure(message: e.message));
    } catch (e) {
      return Left(ChatFailure(message: e.toString()));
    }
    return const Right(ChatSuccess(message: 'Messages Deleted Successfully'));
  }
}

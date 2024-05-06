import 'package:shuttle/src/features/chat/data/models/chat_models.dart';
import 'package:shuttle/src/features/chat/data/models/chat_status_model.dart';
import 'package:shuttle/src/features/chat/data/models/message_model.dart';
import '../../../auth_and_user/data/models/user_model.dart';
import '../../domain/entities/chat_status_entity.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendMessage(
      {required MessageModel message, required String otherUserId});

  Stream<List<MessageModel>> getMessages({required String chatId});

  Stream<List<ChatModel>> getChats();

  Stream<MessageModel> getLatestMessage({required String chatId});

  Stream<int> getNumberOfUnreadMessages({required String chatId});

  Future<Map<String, String?>> getUserNameAndProfileUrl({required String id});

  Future<UserModel> getAppUser({String? id});

  Future<void> messageStatusUpdate({required String chatId});

  Stream<ChatStatusEntity> getUserChatStatus({required String id});

  Future<void> chatStatusUpdate({required ChatStatusModel chatStatusModel});

  Future<void> deleteMessages(
      {required Set messageIdSet, required String chatId});
}

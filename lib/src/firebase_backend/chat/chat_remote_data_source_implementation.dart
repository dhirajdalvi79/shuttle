import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shuttle/src/exceptions_and_failures/exceptions/chat_exceptions.dart';
import 'package:shuttle/src/features/auth_and_user/data/models/user_model.dart';
import 'package:shuttle/src/features/chat/data/models/chat_models.dart';
import 'package:shuttle/src/features/chat/data/models/chat_status_model.dart';
import 'package:shuttle/src/features/chat/data/models/message_model.dart';
import 'package:shuttle/src/features/chat/domain/entities/chat_status_entity.dart';
import 'package:shuttle/src/firebase_backend/common_tasks.dart';
import 'package:shuttle/src/firebase_backend/constants.dart';
import '../../features/chat/data/data_sources/chat_remote_data_source.dart';
import '../firebase_initialize.dart';

class ChatRemoteDataSourceImplementation implements ChatRemoteDataSource {
  const ChatRemoteDataSourceImplementation(
      {required FirebaseInitSingleton firebaseInitSingleton})
      : _firebaseInitSingleton = firebaseInitSingleton;
  final FirebaseInitSingleton _firebaseInitSingleton;

  @override
  Stream<List<ChatModel>> getChats() {
    try {
      final chatRef = _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser?.uid)
          .collection(FirebaseConstants.chats)
          .orderBy('latest_message_timestamp', descending: true)
          .where('latest_message_timestamp',
              isNotEqualTo: DateTime(2000).toIso8601String())
          .snapshots()
          .map((event) {
        return event.docs.map((doc) {
          return ChatModel(
              id: doc.id,
              timeStamp:
                  DateTime.parse(doc.data()['latest_message_timestamp']));
        }).toList();
      });
      return chatRef.handleError((error) {
        if (error is FirebaseException) {
          throw ChatException(message: error.code);
        } else {
          if (error.toString() == 'Bad state: No element') {
            throw const ChatException(message: 'No Chats');
          }
          throw ChatException(message: error.toString());
        }
      });
    } on FirebaseException catch (e) {
      return Stream.error(ChatException(message: e.code));
    } catch (e) {
      return Stream.error(ChatException(message: e.toString()));
    }
  }

  @override
  Stream<List<MessageModel>> getMessages({required String chatId}) {
    try {
      final messageRef = _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser?.uid)
          .collection(FirebaseConstants.chats)
          .doc(chatId)
          .collection(FirebaseConstants.messages)
          .orderBy('created', descending: true)
          .snapshots()
          .map((event) {
        return event.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList();
      });

      return messageRef.handleError((error) {
        if (error is FirebaseException) {
          throw ChatException(message: error.code);
        } else {
          if (error
              .toString()
              .contains('document path must be a non-empty string')) {
            throw const ChatException(message: 'No messages');
          }

          throw ChatException(message: error.toString());
        }
      });
    } on FirebaseException catch (e) {
      return Stream.error(ChatException(message: e.code));
    } catch (e) {
      if (e.toString().contains('document path must be a non-empty string')) {
        throw const ChatException(message: 'No messages');
      }
      return Stream.error(ChatException(message: e.toString()));
    }
  }

  @override
  Future<void> sendMessage(
      {required MessageModel message, required String otherUserId}) async {
    try {
      final userId = _firebaseInitSingleton.firebaseAuth.currentUser?.uid;
      final nameOfUser =
          _firebaseInitSingleton.firebaseAuth.currentUser?.displayName;
      MessageModel sendMessage =
          message.copyWith(senderId: userId, senderName: nameOfUser);
      final Map<String, String> latestMessageTimeStamp = {
        'latest_message_timestamp': sendMessage.created
      };
      final userMessageRef = _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.chats)
          .doc(otherUserId)
          .collection(FirebaseConstants.messages)
          .doc();
      sendMessage = sendMessage.copyWith(id: userMessageRef.id);
      await userMessageRef.set(sendMessage.toMap());

      await _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.chats)
          .doc(otherUserId)
          .update(
            latestMessageTimeStamp,
          );

      final otherUserMessageRef = _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(otherUserId)
          .collection(FirebaseConstants.chats)
          .doc(userId)
          .collection(FirebaseConstants.messages)
          .doc();
      sendMessage = sendMessage.copyWith(id: otherUserMessageRef.id);
      await otherUserMessageRef.set(sendMessage.toMap());

      await _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(otherUserId)
          .collection(FirebaseConstants.chats)
          .doc(userId)
          .update(latestMessageTimeStamp);
    } on FirebaseException catch (e) {
      throw ChatException(message: e.code);
    } catch (e) {
      throw ChatException(message: e.toString());
    }
  }

  @override
  Stream<MessageModel> getLatestMessage({required String chatId}) {
    try {
      final messageRef = _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser?.uid)
          .collection(FirebaseConstants.chats)
          .doc(chatId)
          .collection(FirebaseConstants.messages)
          .orderBy('created', descending: true)
          .snapshots()
          .map((event) {
        final data = event.docs.first.data();
        return MessageModel.fromMap(data);
      });
      return messageRef.handleError((error) {
        if (error is FirebaseException) {
          throw ChatException(message: error.code);
        } else {
          throw ChatException(message: error.toString());
        }
      });
    } on FirebaseException catch (e) {
      return Stream.error(ChatException(message: e.code));
    } catch (e) {
      return Stream.error(ChatException(message: e.toString()));
    }
  }

  @override
  Stream<int> getNumberOfUnreadMessages({required String chatId}) {
    try {
      final messageRef = _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser?.uid)
          .collection(FirebaseConstants.chats)
          .doc(chatId)
          .collection(FirebaseConstants.messages)
          .where('sender_id', isEqualTo: chatId)
          .where('status', isEqualTo: 'SENT')
          .snapshots()
          .map((event) => event.size);
      return messageRef.handleError((error) {
        if (error is FirebaseException) {
          throw ChatException(message: error.code);
        } else {
          throw ChatException(message: error.toString());
        }
      });
    } on FirebaseException catch (e) {
      return Stream.error(ChatException(message: e.code));
    } catch (e) {
      return Stream.error(ChatException(message: e.toString()));
    }
  }

  @override
  Future<Map<String, String?>> getUserNameAndProfileUrl(
      {required String id}) async {
    try {
      final userRef = await _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(id)
          .get();

      Map<String, String?> user = {
        'profile_pic': userRef.data()!['profile_pic'],
        'name': userRef.data()!['name']
      };

      return user;
    } on FirebaseException catch (e) {
      throw ChatException(message: e.code);
    } catch (e) {
      throw ChatException(message: e.toString());
    }
  }

  @override
  Future<UserModel> getAppUser({String? id}) async {
    try {
      final user = await getUserData(
          id: id, firebaseInitSingleton: _firebaseInitSingleton);
      return user;
    } on FirebaseException catch (e) {
      throw ChatException(message: e.code);
    } catch (e) {
      throw ChatException(message: e.toString());
    }
  }

  @override
  Future<void> messageStatusUpdate({required String chatId}) async {
    try {
      final userMessageRef = await _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser?.uid)
          .collection(FirebaseConstants.chats)
          .doc(chatId)
          .collection(FirebaseConstants.messages)
          .where('sender_id', isEqualTo: chatId)
          .where('status', isEqualTo: 'SENT')
          .get();
      // Does Not working
      // userMessageRef.docs.map((e) => e.reference.update({'status': 'READ'}));
      for (var data in userMessageRef.docs) {
        data.reference.update({'status': 'READ'});
      }
      final otherUserMessageRef = await _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(chatId)
          .collection(FirebaseConstants.chats)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser?.uid)
          .collection(FirebaseConstants.messages)
          .where('sender_id', isEqualTo: chatId)
          .where('status', isEqualTo: 'SENT')
          .get();
      // Does Not working
      // otherUserMessageRef.docs.map((e) => e.reference.update({'status': 'READ'}));
      for (var data in otherUserMessageRef.docs) {
        data.reference.update({'status': 'READ'});
      }
    } on FirebaseException catch (e) {
      throw ChatException(message: e.code);
    } catch (e) {
      throw ChatException(message: e.toString());
    }
  }

  @override
  Stream<ChatStatusEntity> getUserChatStatus({required String id}) {
    try {
      return _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(id)
          .collection(FirebaseConstants.chatStatus)
          .doc(FirebaseConstants.chatStatus)
          .snapshots()
          .transform(StreamTransformer.fromHandlers(
              handleError: (error, stackTrace, sink) {
            if (error is FirebaseException) {
              sink.addError(ChatException(message: error.message!));
            } else {
              sink.addError(ChatException(message: error.toString()));
            }
          }, handleData: (data, sink) {
            sink.add(ChatStatusModel.fromMap(data.data()!));
          }));
    } on FirebaseException catch (e) {
      return Stream.error(ChatException(message: e.code));
    } catch (e) {
      return Stream.error(ChatException(message: e.toString()));
    }
  }

  @override
  Future<void> chatStatusUpdate(
      {required ChatStatusModel chatStatusModel}) async {
    try {
      await _firebaseInitSingleton.firebaseFirestore
          .collection(FirebaseConstants.users)
          .doc(_firebaseInitSingleton.firebaseAuth.currentUser?.uid)
          .collection(FirebaseConstants.chatStatus)
          .doc(FirebaseConstants.chatStatus)
          .update(chatStatusModel.toMap());
    } on FirebaseException catch (e) {
      throw ChatException(message: e.code);
    } catch (e) {
      throw ChatException(message: e.toString());
    }
  }

  @override
  Future<void> deleteMessages(
      {required Set messageIdSet, required String chatId}) async {
    try {
      for (final messageId in messageIdSet) {
        await _firebaseInitSingleton.firebaseFirestore
            .collection(FirebaseConstants.users)
            .doc(_firebaseInitSingleton.firebaseAuth.currentUser?.uid)
            .collection(FirebaseConstants.chats)
            .doc(chatId)
            .collection(FirebaseConstants.messages)
            .doc(messageId)
            .delete();
      }
    } on FirebaseException catch (e) {
      throw ChatException(message: e.code);
    } catch (e) {
      throw ChatException(message: e.toString());
    }
  }
}

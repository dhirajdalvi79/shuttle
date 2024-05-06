import 'dart:convert';
import 'package:shuttle/src/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    super.id,
    required super.message,
    super.senderId,
    super.senderName,
    required super.created,
    super.status = MessageStatus.sent,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    late final MessageStatus setStatus;
    switch (map['status']) {
      case 'READ':
        setStatus = MessageStatus.read;
        break;
      case 'SENT':
        setStatus = MessageStatus.sent;
        break;
      default:
        setStatus = MessageStatus.sent;
    }
    return MessageModel(
        id: map['id'],
        message: map['message'],
        senderId: map['sender_id'],
        senderName: map['sender_name'],
        created: map['created'],
        status: setStatus);
  }

  factory MessageModel.fromJson(String json) =>
      MessageModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() {
    late final String setStatus;
    switch (status) {
      case MessageStatus.read:
        setStatus = 'READ';
        break;
      case MessageStatus.sent:
        setStatus = 'SENT';
        break;
      default:
        setStatus = 'SENT';
    }
    return {
      'id': id,
      'message': message,
      'sender_id': senderId,
      'sender_name': senderName,
      'created': created,
      'status': setStatus,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory MessageModel.mapToModelFromEntity(MessageEntity messageEntity) =>
      MessageModel(
        id: messageEntity.id,
        message: messageEntity.message,
        senderId: messageEntity.senderId,
        senderName: messageEntity.senderName,
        created: messageEntity.created,
        status: messageEntity.status,
      );

  @override
  MessageModel copyWith({
    String? id,
    String? message,
    String? senderId,
    String? senderName,
    String? created,
    MessageStatus? status,
  }) {
    return MessageModel(
        id: id ?? this.id,
        message: message ?? this.message,
        senderId: senderId ?? this.senderId,
        senderName: senderName ?? this.senderName,
        created: created ?? this.created,
        status: status ?? this.status);
  }
}

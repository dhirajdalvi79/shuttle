import 'package:equatable/equatable.dart';

enum MessageStatus {
  sent,
  read,
}

class MessageEntity extends Equatable implements Comparable<MessageEntity> {
  final String? id;
  final String message;
  final String? senderId;
  final String? senderName;
  final String created;
  final MessageStatus status;

  const MessageEntity(
      {this.id,
      required this.message,
      this.senderId,
      this.senderName,
      required this.created,
      this.status = MessageStatus.sent});

  MessageEntity copyWith({
    String? id,
    String? message,
    String? senderId,
    String? senderName,
    String? created,
    MessageStatus? status,
  }) {
    return MessageEntity(
        id: id ?? this.id,
        message: message ?? this.message,
        senderId: senderId ?? this.senderId,
        senderName: senderName ?? this.senderName,
        created: created ?? this.created,
        status: status ?? this.status);
  }

  @override
  int compareTo(MessageEntity other) {
    //return created.compareTo(other.created); for ascending
    return other.created.compareTo(created);
  }

  @override
  List<Object?> get props =>
      [id, message, senderId, senderName, created, status];
}

import 'dart:convert';
import 'package:shuttle/src/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    super.id,
    required super.timeStamp,
  });

  ChatModel.fromMap(Map<String, dynamic> map)
      : this(
            id: map['id'],
            timeStamp: DateTime.parse(map['latest_message_timestamp']));

  factory ChatModel.fromJson(String json) =>
      ChatModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        'id': id,
        'latest_message_timestamp': timeStamp.toIso8601String(),
      };

  String toJson() => jsonEncode(toMap());

  factory ChatModel.mapToModelFromEntity(ChatEntity chatEntity) => ChatModel(
        id: chatEntity.id,
        timeStamp: chatEntity.timeStamp,
      );

  @override
  ChatModel copyWith({
    String? id,
    DateTime? timeStamp,
  }) {
    return ChatModel(
      id: id ?? this.id,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  @override
  List<Object?> get props => [
        id,
        timeStamp,
      ];
}

import 'dart:convert';
import 'package:shuttle/src/features/chat/domain/entities/chat_status_entity.dart';

class ChatStatusModel extends ChatStatusEntity {
  const ChatStatusModel({required super.isOnline, required super.typingUser});

  factory ChatStatusModel.fromMap(Map<String, dynamic> map) {
    return ChatStatusModel(
        isOnline: map['is_online'], typingUser: map['typing_user']);
  }

  factory ChatStatusModel.fromJson(String json) =>
      ChatStatusModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() {
    return {
      'is_online': isOnline,
      'typing_user': typingUser,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory ChatStatusModel.mapToModelFromEntity(
          ChatStatusEntity chatStatusEntity) =>
      ChatStatusModel(
          isOnline: chatStatusEntity.isOnline,
          typingUser: chatStatusEntity.typingUser);

  @override
  ChatStatusModel copyWith({bool? isOnline, String? typingUser}) {
    return ChatStatusModel(
        isOnline: isOnline ?? this.isOnline,
        typingUser: typingUser ?? this.typingUser);
  }

  @override
  List<Object?> get props => [isOnline, typingUser];
}

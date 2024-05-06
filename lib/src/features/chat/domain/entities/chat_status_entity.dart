import 'package:equatable/equatable.dart';

class ChatStatusEntity extends Equatable {
  final bool isOnline;
  final String? typingUser;

  const ChatStatusEntity({required this.isOnline, required this.typingUser});

  ChatStatusEntity copyWith({bool? isOnline, String? typingUser}) {
    return ChatStatusEntity(
        isOnline: isOnline ?? this.isOnline,
        typingUser: typingUser ?? this.typingUser);
  }

  @override
  List<Object?> get props => [isOnline, typingUser];
}

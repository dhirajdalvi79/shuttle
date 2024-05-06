part of 'chat_status_update_bloc.dart';

sealed class ChatStatusUpdateEvent extends Equatable {
  const ChatStatusUpdateEvent();

  @override
  List<Object?> get props => [];
}

final class UserIsOnlineChatStatusEvent extends ChatStatusUpdateEvent {
  const UserIsOnlineChatStatusEvent();
}

final class UserIsNotOnlineChatStatusEvent extends ChatStatusUpdateEvent {
  const UserIsNotOnlineChatStatusEvent();
}

final class UserIsTypingChatStatusEvent extends ChatStatusUpdateEvent {
  final String id;

  const UserIsTypingChatStatusEvent({required this.id});
}

final class UserIsNotTypingChatStatusEvent extends ChatStatusUpdateEvent {
  const UserIsNotTypingChatStatusEvent();
}

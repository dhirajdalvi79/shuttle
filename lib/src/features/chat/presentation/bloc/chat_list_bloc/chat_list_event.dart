part of 'chat_list_bloc.dart';

sealed class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object?> get props => [];
}

final class GetChatListEvent extends ChatListEvent {
  const GetChatListEvent();
}

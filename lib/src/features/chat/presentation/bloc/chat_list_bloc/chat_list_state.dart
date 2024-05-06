part of 'chat_list_bloc.dart';

sealed class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object?> get props => [];
}

final class ChatListInitial extends ChatListState {
  const ChatListInitial();
}

final class ChatListLoadingState extends ChatListState {
  const ChatListLoadingState();
}

final class ChatListLoadedState extends ChatListState {
  const ChatListLoadedState({required this.chatList});

  final List<ChatEntity> chatList;

  @override
  List<Object?> get props => [chatList];
}

final class ChatListEmptyState extends ChatListState {
  const ChatListEmptyState();
}

final class ChatListErrorState extends ChatListState {
  const ChatListErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

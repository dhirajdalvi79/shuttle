part of 'chat_messages_bloc.dart';

sealed class ChatMessagesState extends Equatable {
  const ChatMessagesState();

  @override
  List<Object?> get props => [];
}

final class ChatMessagesInitial extends ChatMessagesState {
  const ChatMessagesInitial();
}

final class ChatMessagesLoadedState extends ChatMessagesState {
  final List<MessageEntity> messages;

  const ChatMessagesLoadedState({required this.messages});

  @override
  List<Object?> get props => [messages];
}

final class ChatMessagesLoadingState extends ChatMessagesState {
  const ChatMessagesLoadingState();
}

final class ChatMessagesEmptyState extends ChatMessagesState {
  const ChatMessagesEmptyState();
}

final class ChatMessagesErrorState extends ChatMessagesState {
  final String message;

  const ChatMessagesErrorState({required this.message});
}

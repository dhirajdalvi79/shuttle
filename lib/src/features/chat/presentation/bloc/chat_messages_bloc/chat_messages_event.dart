part of 'chat_messages_bloc.dart';

sealed class ChatMessagesEvent extends Equatable {
  const ChatMessagesEvent();

  @override
  List<Object?> get props => [];
}

final class GetMessagesEvent extends ChatMessagesEvent {
  final String id;

  const GetMessagesEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

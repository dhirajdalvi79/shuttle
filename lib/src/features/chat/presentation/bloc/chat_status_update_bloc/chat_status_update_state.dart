part of 'chat_status_update_bloc.dart';

sealed class ChatStatusUpdateState extends Equatable {
  const ChatStatusUpdateState();

  @override
  List<Object?> get props => [];
}

final class ChatStatusUpdateInitial extends ChatStatusUpdateState {
  const ChatStatusUpdateInitial();
}

final class ChatStatusUpdateSuccess extends ChatStatusUpdateState {
  final String message;

  const ChatStatusUpdateSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ChatStatusUpdateFailure extends ChatStatusUpdateState {
  final String message;

  const ChatStatusUpdateFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

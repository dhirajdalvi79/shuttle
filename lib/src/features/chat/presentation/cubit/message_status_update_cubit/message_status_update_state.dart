part of 'message_status_update_cubit.dart';

sealed class MessageStatusUpdateState extends Equatable {
  const MessageStatusUpdateState();

  @override
  List<Object?> get props => [];
}

final class MessageStatusUpdateInitial extends MessageStatusUpdateState {
  const MessageStatusUpdateInitial();
}

final class MessageStatusUpdateSuccess extends MessageStatusUpdateState {
  final String message;

  const MessageStatusUpdateSuccess({required this.message});
}

final class MessageStatusUpdateFailure extends MessageStatusUpdateState {
  final String message;

  const MessageStatusUpdateFailure({required this.message});
}

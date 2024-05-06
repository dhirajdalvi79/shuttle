part of 'send_message_bloc.dart';

sealed class SendMessageEvent extends Equatable {
  const SendMessageEvent();

  @override
  List<Object?> get props => [];
}

final class SendTextMessageEvent extends SendMessageEvent {
  final SendMessageParameter sendMessageParameter;

  const SendTextMessageEvent({required this.sendMessageParameter});
}

part of 'send_message_bloc.dart';

sealed class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object?> get props => [];
}

final class SendMessageInitial extends SendMessageState {
  const SendMessageInitial();
}

final class SendTextMessageSuccess extends SendMessageState {
  const SendTextMessageSuccess();
}

final class SendTextMessageFailure extends SendMessageState {
  final String message;

  const SendTextMessageFailure({required this.message});
}

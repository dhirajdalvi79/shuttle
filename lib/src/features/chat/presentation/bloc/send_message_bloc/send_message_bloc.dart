import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/features/chat/domain/usecases/send_message.dart';

part 'send_message_event.dart';

part 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  SendMessageBloc({required SendMessage sendMessage})
      : _sendMessage = sendMessage,
        super(const SendMessageInitial()) {
    on<SendTextMessageEvent>(_sendTextMessageEvent);
  }

  final SendMessage _sendMessage;

  void _sendTextMessageEvent(
      SendTextMessageEvent event, Emitter<SendMessageState> emit) async {
    final result = await _sendMessage(parameter: event.sendMessageParameter);
    result.fold(
        (failure) => emit(SendTextMessageFailure(message: failure.message)),
        (success) => emit(const SendTextMessageSuccess()));
  }
}

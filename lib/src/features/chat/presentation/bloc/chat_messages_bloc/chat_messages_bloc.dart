import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/usecases/get_messages.dart';

part 'chat_messages_event.dart';

part 'chat_messages_state.dart';

class ChatMessagesBloc extends Bloc<ChatMessagesEvent, ChatMessagesState> {
  ChatMessagesBloc({required GetMessages getMessages})
      : _getMessages = getMessages,
        super(const ChatMessagesInitial()) {
    on<GetMessagesEvent>(_getMessagesEvent);
  }

  final GetMessages _getMessages;

  void _getMessagesEvent(
      GetMessagesEvent event, Emitter<ChatMessagesState> emit) async {
    await emit.forEach(_getMessages(parameter: event.id), onData: (data) {
      return data.fold(
          (failure) => ChatMessagesErrorState(message: failure.message),
          (messages) => ChatMessagesLoadedState(messages: messages));
    }, onError: (error, stackTrace) {
      return ChatMessagesErrorState(message: error.toString());
    });
  }
}

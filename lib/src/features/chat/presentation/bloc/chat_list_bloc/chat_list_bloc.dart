import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/features/chat/domain/usecases/get_chats.dart';
import '../../../domain/entities/chat_entity.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc({required GetChats getChats})
      : _getChats = getChats,
        super(const ChatListInitial()) {
    on<GetChatListEvent>(_getChatListEventHandler);
  }

  final GetChats _getChats;

  void _getChatListEventHandler(
      GetChatListEvent event, Emitter<ChatListState> emit) async {
    emit(const ChatListLoadingState());

    await emit.forEach(_getChats(), onData: (data) {
      return data.fold(
          (failure) => ChatListErrorState(message: failure.message),
          (chatList) => ChatListLoadedState(chatList: chatList));
    }, onError: (error, stackTrace) {
      return ChatListErrorState(message: error.toString());
    });
  }
}

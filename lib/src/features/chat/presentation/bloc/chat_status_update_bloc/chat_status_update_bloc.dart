import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/features/chat/domain/entities/chat_status_entity.dart';
import '../../../domain/usecases/chat_status_update.dart';

part 'chat_status_update_event.dart';

part 'chat_status_update_state.dart';

class ChatStatusUpdateBloc
    extends Bloc<ChatStatusUpdateEvent, ChatStatusUpdateState> {
  ChatStatusUpdateBloc({required ChatStatusUpdate chatStatusUpdate})
      : _chatStatusUpdate = chatStatusUpdate,
        super(const ChatStatusUpdateInitial()) {
    on<UserIsOnlineChatStatusEvent>(_userIsOnlineChatStatusEvent);
    on<UserIsNotOnlineChatStatusEvent>(_userIsNotOnlineChatStatusEvent);
    on<UserIsTypingChatStatusEvent>(_userIsTypingChatStatusEvent);
    on<UserIsNotTypingChatStatusEvent>(_userIsNotTypingChatStatusEvent);
  }

  final ChatStatusUpdate _chatStatusUpdate;

  void _userIsOnlineChatStatusEvent(UserIsOnlineChatStatusEvent event,
      Emitter<ChatStatusUpdateState> emit) async {
    await _chatStatusUpdate(
        parameter: const ChatStatusEntity(isOnline: true, typingUser: null));
  }

  void _userIsNotOnlineChatStatusEvent(UserIsNotOnlineChatStatusEvent event,
      Emitter<ChatStatusUpdateState> emit) async {
    await _chatStatusUpdate(
        parameter: const ChatStatusEntity(isOnline: false, typingUser: null));
  }

  void _userIsTypingChatStatusEvent(UserIsTypingChatStatusEvent event,
      Emitter<ChatStatusUpdateState> emit) async {
    await _chatStatusUpdate(
        parameter: ChatStatusEntity(isOnline: true, typingUser: event.id));
  }

  void _userIsNotTypingChatStatusEvent(UserIsNotTypingChatStatusEvent event,
      Emitter<ChatStatusUpdateState> emit) async {
    await _chatStatusUpdate(
        parameter: const ChatStatusEntity(isOnline: true, typingUser: null));
  }
}

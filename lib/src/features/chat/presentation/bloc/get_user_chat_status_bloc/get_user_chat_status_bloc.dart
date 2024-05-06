import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/features/chat/domain/entities/chat_status_entity.dart';
import '../../../domain/usecases/get_user_chat_status.dart';

part 'get_user_chat_status_event.dart';

part 'get_user_chat_status_state.dart';

class GetUserChatStatusBloc
    extends Bloc<GetUserChatStatusEvent, GetUserChatStatusState> {
  GetUserChatStatusBloc({required GetUserChatStatus getUserChatStatus})
      : _getUserChatStatus = getUserChatStatus,
        super(const GetUserChatStatusInitial()) {
    on<GetUserChatStatusEvent>(_getUserChatStatusEvent);
  }

  final GetUserChatStatus _getUserChatStatus;

  void _getUserChatStatusEvent(GetUserChatStatusEvent event,
      Emitter<GetUserChatStatusState> emit) async {
    await emit.forEach(_getUserChatStatus(parameter: event.id), onData: (data) {
      return data.fold(
          (failure) => GetUserChatStatusErrorState(message: failure.message),
          (chatStatusEntity) =>
              GetUserChatStatusLoadedState(chatStatusEntity: chatStatusEntity));
    }, onError: (error, stackTrace) {
      return GetUserChatStatusErrorState(message: error.toString());
    });
  }
}

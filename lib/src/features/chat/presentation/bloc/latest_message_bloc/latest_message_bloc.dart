import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/usecases/get_latest_message.dart';

part 'latest_message_event.dart';

part 'latest_message_state.dart';

class LatestMessageBloc extends Bloc<LatestMessageEvent, LatestMessageState> {
  LatestMessageBloc({required GetLatestMessage getLatestMessage})
      : _getLatestMessage = getLatestMessage,
        super(const LatestMessageInitial()) {
    on<GetInitialLatestMessageEvent>(_getLatestMessageEventHandler);
  }

  final GetLatestMessage _getLatestMessage;

  void _getLatestMessageEventHandler(GetInitialLatestMessageEvent event,
      Emitter<LatestMessageState> emit) async {
    emit(const LoadingLatestMessageState());

    await emit.forEach(_getLatestMessage(parameter: event.chatId),
        onData: (data) {
      return data.fold(
          (failure) => LatestMessageErrorState(message: failure.message),
          (messageEntity) =>
              LatestMessageLoadedState(messageEntity: messageEntity));
    }, onError: (error, stackTrace) {
      return LatestMessageErrorState(message: error.toString());
    });
  }
}

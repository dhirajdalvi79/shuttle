import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_number_of_unread_messages.dart';

part 'number_of_message_event.dart';

part 'number_of_message_state.dart';

class NumberOfMessageBloc
    extends Bloc<NumberOfMessageEvent, NumberOfMessageState> {
  NumberOfMessageBloc(
      {required GetNumberOfUnreadMessages getNumberOfUnreadMessages})
      : _getNumberOfUnreadMessages = getNumberOfUnreadMessages,
        super(const NumberOfMessageInitial()) {
    on<GetNumberOfUnreadMessagesEvent>(_getNumberOfUnreadMessagesEventHandler);
  }

  final GetNumberOfUnreadMessages _getNumberOfUnreadMessages;

  void _getNumberOfUnreadMessagesEventHandler(
      GetNumberOfUnreadMessagesEvent event,
      Emitter<NumberOfMessageState> emit) async {
    emit(const LoadingNumberOfUnreadMessagesState());

    await emit.forEach(_getNumberOfUnreadMessages(parameter: event.chatId),
        onData: (data) {
      return data.fold(
          (failure) =>
              NumberOfUnreadMessagesErrorState(message: failure.message),
          (numberOfUnreadMessages) => NumberOfUnreadMessagesState(
              numberOfUnreadMessages: numberOfUnreadMessages));
    }, onError: (error, stackTrace) {
      return NumberOfUnreadMessagesErrorState(message: error.toString());
    });
  }
}

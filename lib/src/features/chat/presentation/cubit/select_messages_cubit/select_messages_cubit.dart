import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/delete_messages.dart';

part 'select_messages_state.dart';

class SelectMessagesCubit extends Cubit<SelectMessagesState> {
  SelectMessagesCubit({required DeleteMessages deleteMessages})
      : _deleteMessages = deleteMessages,
        super(SelectMessagesInitial());
  final Set<String> messagesSet = {};
  final DeleteMessages _deleteMessages;

  /*
  In selectMessage and deselectMessage, we create a new Set.from(messagesSet) before
   emitting the new state. This ensures that Bloc recognizes the updated set as a different object,
   triggering a rebuild of the UI components listening to the Cubit's state.*/

  void selectMessage({required String messageId}) {
    messagesSet.add(messageId);
    emit(SelectedMessagesSet(selectedMessages: Set.from(messagesSet)));
  }

  void deselectMessage({required String messageId}) {
    messagesSet.remove(messageId);
    emit(SelectedMessagesSet(selectedMessages: Set.from(messagesSet)));
  }

  void emptyMessageSet() {
    messagesSet.clear();
    emit(SelectedMessagesSet(selectedMessages: Set.from(messagesSet)));
  }

  void deleteMessages(
      {required DeleteMessagesParameter deleteMessagesParameter}) async {
    emit(const DeleteMessagesLoadingState());
    final result = await _deleteMessages(parameter: deleteMessagesParameter);
    result.fold(
        (failure) => emit(DeleteMessagesErrorState(message: failure.message)),
        (success) {
      emit(const DeletedMessagesSuccessState());
      messagesSet.clear();
    });
  }
}

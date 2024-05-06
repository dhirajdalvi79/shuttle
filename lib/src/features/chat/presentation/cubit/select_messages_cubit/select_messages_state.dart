part of 'select_messages_cubit.dart';

sealed class SelectMessagesState extends Equatable {
  const SelectMessagesState();

  @override
  List<Object> get props => [];
}

final class SelectMessagesInitial extends SelectMessagesState {
  final Set<String> selectedMessages = {};

  SelectMessagesInitial();

  @override
  List<Object> get props => [selectedMessages];
}

final class SelectedMessagesSet extends SelectMessagesState {
  final Set<String> selectedMessages;

  const SelectedMessagesSet({required this.selectedMessages});

  @override
  List<Object> get props => [selectedMessages];
}

final class DeleteMessagesLoadingState extends SelectMessagesState {
  const DeleteMessagesLoadingState();
}

final class DeletedMessagesSuccessState extends SelectMessagesState {
  const DeletedMessagesSuccessState();
}

final class DeleteMessagesErrorState extends SelectMessagesState {
  final String message;

  const DeleteMessagesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

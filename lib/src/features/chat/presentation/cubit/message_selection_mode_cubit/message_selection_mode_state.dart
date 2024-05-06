part of 'message_selection_mode_cubit.dart';

sealed class MessageSelectionModeState extends Equatable {
  const MessageSelectionModeState();

  @override
  List<Object?> get props => [];
}

final class MessageSelectionModeOffState extends MessageSelectionModeState {
  const MessageSelectionModeOffState();
}

final class MessageSelectionModeOnState extends MessageSelectionModeState {
  const MessageSelectionModeOnState();
}

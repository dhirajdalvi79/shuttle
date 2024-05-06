import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_selection_mode_state.dart';

class MessageSelectionModeCubit extends Cubit<MessageSelectionModeState> {
  MessageSelectionModeCubit() : super(const MessageSelectionModeOffState());

  void setMessageSelectionModeOff() {
    emit(const MessageSelectionModeOffState());
  }

  void setMessageSelectionModeOn() {
    emit(const MessageSelectionModeOnState());
  }
}

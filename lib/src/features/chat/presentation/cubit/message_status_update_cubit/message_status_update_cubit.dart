import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/message_status_update.dart';

part 'message_status_update_state.dart';

class MessageStatusUpdateCubit extends Cubit<MessageStatusUpdateState> {
  MessageStatusUpdateCubit({required MessageStatusUpdate messageStatusUpdate})
      : _messageStatusUpdate = messageStatusUpdate,
        super(const MessageStatusUpdateInitial());
  final MessageStatusUpdate _messageStatusUpdate;

  void updateMessageStatus({required String id}) async {
    final result = await _messageStatusUpdate(parameter: id);
    result.fold(
        (failure) => emit(MessageStatusUpdateFailure(message: failure.message)),
        (success) =>
            emit(MessageStatusUpdateSuccess(message: success.message)));
  }
}

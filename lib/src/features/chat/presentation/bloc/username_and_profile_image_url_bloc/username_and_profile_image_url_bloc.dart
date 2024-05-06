import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/features/chat/domain/usecases/get_user_name_and_profile_url.dart';

part 'username_and_profile_image_url_event.dart';

part 'username_and_profile_image_url_state.dart';

class UserNameAndProfileImageUrlBloc extends Bloc<
    UserNameAndProfileImageUrlEvent, UserNameAndProfileImageUrlState> {
  UserNameAndProfileImageUrlBloc({
    required GetUserNameAndProfileUrl getUserNameAndProfileUrl,
  })  : _getUserNameAndProfileUrl = getUserNameAndProfileUrl,
        super(const ChatInitial()) {
    on<GetUserNameAndProfileUrlEvent>(_getUserNameAndProfileUrlEventHandler);
  }

  final GetUserNameAndProfileUrl _getUserNameAndProfileUrl;

  void _getUserNameAndProfileUrlEventHandler(
      GetUserNameAndProfileUrlEvent event,
      Emitter<UserNameAndProfileImageUrlState> emit) async {
    emit(const LoadingUserNameAndProfileUrlState());
    final result = await _getUserNameAndProfileUrl(parameter: event.chatId);

    result.fold(
        (failure) =>
            emit(UserNameAndProfileUrlErrorState(message: failure.message)),
        (user) => emit(UserNameAndProfileImageUrlLoadedState(user: user)));
  }
}

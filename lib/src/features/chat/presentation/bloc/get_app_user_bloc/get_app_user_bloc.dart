import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/features/auth_and_user/domain/entities/user_entity.dart';
import '../../../../../exceptions_and_failures/failures/failures.dart';
import '../../../domain/usecases/get_app_user.dart';

part 'get_app_user_event.dart';

part 'get_app_user_state.dart';

class GetAppUserBloc extends Bloc<GetAppUserEvent, GetAppUserState> {
  GetAppUserBloc({required GetAppUser getAppUser})
      : _getAppUser = getAppUser,
        super(const GetAppUserInitial()) {
    on<GetUserEvent>(_getUserEvent);
  }

  final GetAppUser _getAppUser;

  void _getUserEvent(GetUserEvent event, Emitter<GetAppUserState> emit) async {
    emit(const LoadingAppUserState());
    late Either<Failure, UserEntity> user;
    if (event.id == null) {
      user = await _getAppUser();
    } else {
      user = await _getAppUser(parameter: event.id);
    }
    user.fold((failure) => emit(GetAppUserErrorState(message: failure.message)),
        (user) => emit(LoadedAppUserState(userEntity: user)));
  }
}

part of 'get_app_user_bloc.dart';

abstract class GetAppUserState extends Equatable {
  const GetAppUserState();

  @override
  List<Object?> get props => [];
}

final class GetAppUserInitial extends GetAppUserState {
  const GetAppUserInitial();
}

final class LoadingAppUserState extends GetAppUserState {
  const LoadingAppUserState();
}

final class LoadedAppUserState extends GetAppUserState {
  final UserEntity userEntity;

  const LoadedAppUserState({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

final class GetAppUserErrorState extends GetAppUserState {
  final String message;

  const GetAppUserErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

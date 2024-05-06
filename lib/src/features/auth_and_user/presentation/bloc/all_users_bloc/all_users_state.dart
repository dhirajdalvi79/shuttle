part of 'all_users_bloc.dart';

sealed class AllUsersState extends Equatable {
  const AllUsersState();

  @override
  List<Object?> get props => [];
}

final class AllUsersInitial extends AllUsersState {
  const AllUsersInitial();
}

final class LoadingAllUsersState extends AllUsersState {
  const LoadingAllUsersState();
}

final class LoadedAllUsersState extends AllUsersState {
  final List<UserEntity> users;

  const LoadedAllUsersState({required this.users});

  @override
  List<Object?> get props => [users];
}

final class GetAllUsersErrorState extends AllUsersState {
  final String message;

  const GetAllUsersErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

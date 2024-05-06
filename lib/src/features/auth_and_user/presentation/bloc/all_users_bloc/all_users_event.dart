part of 'all_users_bloc.dart';

sealed class AllUsersEvent extends Equatable {
  const AllUsersEvent();

  @override
  List<Object?> get props => [];
}

final class GetAllUsersEvent extends AllUsersEvent {
  const GetAllUsersEvent();
}

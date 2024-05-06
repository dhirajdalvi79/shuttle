import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_all_users.dart';

part 'all_users_event.dart';

part 'all_users_state.dart';

class AllUsersBloc extends Bloc<AllUsersEvent, AllUsersState> {
  AllUsersBloc({required GetAllUsers getAllUsers})
      : _getAllUsers = getAllUsers,
        super(const AllUsersInitial()) {
    on<GetAllUsersEvent>(_getAllUsersEventHandler);
  }

  final GetAllUsers _getAllUsers;

  void _getAllUsersEventHandler(
      GetAllUsersEvent event, Emitter<AllUsersState> emit) async {
    emit(const LoadingAllUsersState());
    final users = await _getAllUsers();
    users.fold(
        (failure) => emit(GetAllUsersErrorState(message: failure.message)),
        (users) => emit(LoadedAllUsersState(users: users)));
  }
}

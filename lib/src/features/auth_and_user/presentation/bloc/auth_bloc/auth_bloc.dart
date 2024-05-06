import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/features/auth_and_user/domain/usecases/logout.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/signup.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required LogIn login, required SignUp signUp, required LogOut logOut})
      : _logIn = login,
        _signUp = signUp,
        _logOut = logOut,
        super(const AuthInitial()) {
    on<LogInEvent>(_logInEventHandler);
    on<SignUpEvent>(_signUpEventHandler);
    on<LogOutEvent>(_logOutEventHandler);
  }

  final LogIn _logIn;
  final SignUp _signUp;
  final LogOut _logOut;

  void _logInEventHandler(LogInEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _logIn(
        parameter:
            UserLogInCredEntity(email: event.email, password: event.password));
    result.fold((failure) => emit(LogInFailure(message: failure.message)),
        (success) => emit(LogInSuccess(message: success.message)));
  }

  void _signUpEventHandler(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _signUp(
        parameter: UserEntity(
            name: event.name,
            email: event.email,
            password: event.password,
            userName: event.userName,
            profileImageUrl: event.profileImageUrl,
            bio: event.bio,
            birthDate: event.birthDate));
    await result.fold(
        (failure) async => emit(SignUpFailure(message: failure.message)),
        (success) async => emit(SignUpSuccess(message: success.message)));
  }

  void _logOutEventHandler(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _logOut();
    result.fold((failure) => emit(LogoutFailure(message: failure.message)),
        (success) => emit(const LogoutSuccess()));
  }
}

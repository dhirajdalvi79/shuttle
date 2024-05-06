part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class LogInSuccess extends AuthState {
  const LogInSuccess({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class LogInFailure extends AuthState {
  const LogInFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SignUpSuccess extends AuthState {
  const SignUpSuccess({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SignUpFailure extends AuthState {
  const SignUpFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

final class LogoutSuccess extends AuthState {
  const LogoutSuccess();
}

final class LogoutFailure extends AuthState {
  final String message;

  const LogoutFailure({required this.message});
}

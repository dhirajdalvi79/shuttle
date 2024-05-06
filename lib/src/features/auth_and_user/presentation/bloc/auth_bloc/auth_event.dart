part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LogInEvent extends AuthEvent {
  const LogInEvent({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent(
      {this.id,
      required this.userName,
      required this.name,
      required this.email,
      this.password,
      this.profileImageUrl,
      required this.bio,
      required this.birthDate});

  final String? id;
  final String userName;
  final String name;
  final String email;
  final String? password;
  final String? profileImageUrl;
  final String bio;
  final DateTime birthDate;

  @override
  List<Object?> get props =>
      [id, userName, name, email, password, profileImageUrl, bio, birthDate];
}

class LogOutEvent extends AuthEvent {
  const LogOutEvent();
}

part of 'initial_screen_bloc.dart';

sealed class InitialScreenAuthState {
  const InitialScreenAuthState();
}

class LoadingState extends InitialScreenAuthState {}

class LoggedInState extends InitialScreenAuthState {}

class LoggedOutState extends InitialScreenAuthState {}

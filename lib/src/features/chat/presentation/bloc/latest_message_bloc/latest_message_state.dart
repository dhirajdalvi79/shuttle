part of 'latest_message_bloc.dart';

abstract class LatestMessageState extends Equatable {
  const LatestMessageState();

  @override
  List<Object?> get props => [];
}

final class LatestMessageInitial extends LatestMessageState {
  const LatestMessageInitial();
}

final class LoadingLatestMessageState extends LatestMessageState {
  const LoadingLatestMessageState();
}

final class LatestMessageLoadedState extends LatestMessageState {
  final MessageEntity messageEntity;

  const LatestMessageLoadedState({required this.messageEntity});

  @override
  List<Object?> get props => [messageEntity];
}

final class LatestMessageErrorState extends LatestMessageState {
  final String message;

  const LatestMessageErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

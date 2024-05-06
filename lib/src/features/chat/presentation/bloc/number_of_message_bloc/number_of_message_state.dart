part of 'number_of_message_bloc.dart';

abstract class NumberOfMessageState extends Equatable {
  const NumberOfMessageState();

  @override
  List<Object?> get props => [];
}

class NumberOfMessageInitial extends NumberOfMessageState {
  const NumberOfMessageInitial();
}

final class LoadingNumberOfUnreadMessagesState extends NumberOfMessageState {
  const LoadingNumberOfUnreadMessagesState();
}

final class NumberOfUnreadMessagesState extends NumberOfMessageState {
  final int numberOfUnreadMessages;

  const NumberOfUnreadMessagesState({required this.numberOfUnreadMessages});

  @override
  List<Object?> get props => [numberOfUnreadMessages];
}

final class NumberOfUnreadMessagesErrorState extends NumberOfMessageState {
  final String message;

  const NumberOfUnreadMessagesErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

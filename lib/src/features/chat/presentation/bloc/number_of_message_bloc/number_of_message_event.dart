part of 'number_of_message_bloc.dart';

abstract class NumberOfMessageEvent extends Equatable {
  const NumberOfMessageEvent();
}

final class GetNumberOfUnreadMessagesEvent extends NumberOfMessageEvent {
  final String chatId;

  const GetNumberOfUnreadMessagesEvent({required this.chatId});

  @override
  List<Object?> get props => [chatId];
}

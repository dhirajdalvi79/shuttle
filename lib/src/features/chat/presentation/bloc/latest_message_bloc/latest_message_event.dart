part of 'latest_message_bloc.dart';

abstract class LatestMessageEvent extends Equatable {
  const LatestMessageEvent();

  @override
  List<Object?> get props => [];
}

final class GetInitialLatestMessageEvent extends LatestMessageEvent {
  final String chatId;

  const GetInitialLatestMessageEvent({required this.chatId});

  @override
  List<Object?> get props => [chatId];
}

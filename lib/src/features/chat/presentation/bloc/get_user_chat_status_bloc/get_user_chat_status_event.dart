part of 'get_user_chat_status_bloc.dart';

final class GetUserChatStatusEvent extends Equatable {
  final String id;

  const GetUserChatStatusEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

part of 'get_user_chat_status_bloc.dart';

sealed class GetUserChatStatusState extends Equatable {
  const GetUserChatStatusState();

  @override
  List<Object?> get props => [];
}

final class GetUserChatStatusInitial extends GetUserChatStatusState {
  const GetUserChatStatusInitial();
}

final class GetUserChatStatusLoadingState extends GetUserChatStatusState {
  const GetUserChatStatusLoadingState();
}

final class GetUserChatStatusLoadedState extends GetUserChatStatusState {
  final ChatStatusEntity chatStatusEntity;

  const GetUserChatStatusLoadedState({required this.chatStatusEntity});

  @override
  List<Object?> get props => [chatStatusEntity];
}

final class GetUserChatStatusErrorState extends GetUserChatStatusState {
  final String message;

  const GetUserChatStatusErrorState({required this.message});
}

part of 'username_and_profile_image_url_bloc.dart';

sealed class UserNameAndProfileImageUrlEvent extends Equatable {
  const UserNameAndProfileImageUrlEvent();

  @override
  List<Object?> get props => [];
}

final class GetUserNameAndProfileUrlEvent
    extends UserNameAndProfileImageUrlEvent {
  final String chatId;

  const GetUserNameAndProfileUrlEvent({required this.chatId});

  @override
  List<Object?> get props => [chatId];
}

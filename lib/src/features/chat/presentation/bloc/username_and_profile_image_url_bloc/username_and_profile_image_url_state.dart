part of 'username_and_profile_image_url_bloc.dart';

sealed class UserNameAndProfileImageUrlState extends Equatable {
  const UserNameAndProfileImageUrlState();

  @override
  List<Object?> get props => [];
}

final class ChatInitial extends UserNameAndProfileImageUrlState {
  const ChatInitial();
}

final class LoadingUserNameAndProfileUrlState
    extends UserNameAndProfileImageUrlState {
  const LoadingUserNameAndProfileUrlState();
}

final class UserNameAndProfileImageUrlLoadedState
    extends UserNameAndProfileImageUrlState {
  final Map<String, String?> user;

  const UserNameAndProfileImageUrlLoadedState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class UserNameAndProfileUrlErrorState
    extends UserNameAndProfileImageUrlState {
  final String message;

  const UserNameAndProfileUrlErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

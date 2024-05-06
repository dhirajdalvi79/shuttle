part of 'profile_image_bloc.dart';

sealed class ProfileImageState extends Equatable {
  final String? profileImagePath;
  final Uint8List? profileImageBytes;

  const ProfileImageState(
      {required this.profileImagePath, required this.profileImageBytes});

  @override
  List<Object?> get props => [profileImagePath, profileImageBytes];
}

final class ProfileImageEmpty extends ProfileImageState {
  const ProfileImageEmpty({super.profileImagePath, super.profileImageBytes});
}

final class ProfileImageSelected extends ProfileImageState {
  const ProfileImageSelected(
      {required super.profileImagePath, required super.profileImageBytes});
}

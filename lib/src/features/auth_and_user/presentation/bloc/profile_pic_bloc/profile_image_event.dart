part of 'profile_image_bloc.dart';

class ProfileImageSelectEvent extends Equatable {
  final String profileImage;
  final Uint8List profileImageBytes;

  const ProfileImageSelectEvent(
      {required this.profileImage, required this.profileImageBytes});

  @override
  List<Object?> get props => [profileImage, profileImageBytes];
}

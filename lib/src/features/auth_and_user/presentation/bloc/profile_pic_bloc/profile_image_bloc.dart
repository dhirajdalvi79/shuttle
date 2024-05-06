import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_image_event.dart';

part 'profile_image_state.dart';

class ProfileImageBloc
    extends Bloc<ProfileImageSelectEvent, ProfileImageState> {
  ProfileImageBloc() : super(const ProfileImageEmpty()) {
    on<ProfileImageSelectEvent>(_profileImageSelectEventHandler);
  }

  void _profileImageSelectEventHandler(
      ProfileImageSelectEvent event, Emitter<ProfileImageState> emit) {
    emit(ProfileImageSelected(
        profileImagePath: event.profileImage,
        profileImageBytes: event.profileImageBytes));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/common_methods/io_methods/io_method.dart';
import '../bloc/profile_pic_bloc/profile_image_bloc.dart';

class ProfileImagesSourceSelector extends StatefulWidget {
  const ProfileImagesSourceSelector({super.key});

  @override
  State<ProfileImagesSourceSelector> createState() =>
      _ImagesSourceSelectorState();
}

class _ImagesSourceSelectorState extends State<ProfileImagesSourceSelector> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Selects source of image to be of gallery.
            GestureDetector(
              onTap: () async {
                final profileImageBloc = context.read<ProfileImageBloc>();
                const ioMethods = UserIoMethods();
                final image = await ioMethods.selectImage(ImageSource.gallery);
                if (image != null) {
                  profileImageBloc.add(ProfileImageSelectEvent(
                      profileImage: image.profileImagePath,
                      profileImageBytes: image.profileImageByte));
                }
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text(
                'Gallery',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Selects source of image to be of camera.
            GestureDetector(
              onTap: () async {
                final profileImageBloc = context.read<ProfileImageBloc>();
                const ioMethods = UserIoMethods();
                final image = await ioMethods.selectImage(ImageSource.camera);
                if (image != null) {
                  profileImageBloc.add(ProfileImageSelectEvent(
                      profileImage: image.profileImagePath,
                      profileImageBytes: image.profileImageByte));
                }
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text(
                'Camera',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}

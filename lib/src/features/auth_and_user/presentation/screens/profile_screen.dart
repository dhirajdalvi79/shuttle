import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:shuttle/src/features/auth_and_user/domain/entities/user_entity.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/bloc/add_to_contact_bloc/add_to_contact_bloc.dart';
import '../../../../core/service_locator/injection_container.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/contact_exists_bloc/contact_exists_bloc.dart';
import '../widgets/profile_button_set.dart';
import '../widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ContactExistsBloc>(),
        ),
        BlocProvider(create: (context) => sl<AddToContactBloc>())
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      backgroundImage: userEntity.profileImageUrl != null
                          ? NetworkImage(userEntity.profileImageUrl!)
                          : const AssetImage(profilePicPlaceholder)
                              as ImageProvider,
                      radius: 75,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      userEntity.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileButtonSet(
                      id: userEntity.id!,
                      nameOfUser: userEntity.name,
                      userProfilePic: userEntity.profileImageUrl,
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileTile(
                  icon: AntDesign.edit_outline, content: userEntity.bio),
              ProfileTile(icon: Icons.mail_outline, content: userEntity.email),
              ProfileTile(
                icon: CupertinoIcons.gift,
                content: DateFormat()
                    .add_d()
                    .add_MMMM()
                    .add_y()
                    .format(userEntity.birthDate),
              )
            ],
          ),
        ),
      ),
    );
  }
}

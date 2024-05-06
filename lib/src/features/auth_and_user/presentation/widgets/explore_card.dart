import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shuttle/src/features/auth_and_user/domain/entities/user_entity.dart';
import '../../../../core/utils/constants.dart';
import '../../../../routes/route_path_constants.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: userEntity.profileImageUrl != null
                ? NetworkImage(userEntity.profileImageUrl!)
                : const AssetImage(profilePicPlaceholder) as ImageProvider,
            radius: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: GestureDetector(
            onTap: () => context.goNamed(profileScreen, extra: userEntity),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userEntity.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(userEntity.userName),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

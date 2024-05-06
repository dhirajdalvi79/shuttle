import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shuttle/src/features/auth_and_user/domain/entities/user_entity.dart';
import '../../../../core/utils/constants.dart';
import '../../../../routes/route_path_constants.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(profileScreen, extra: userEntity),
      child: Container(
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
              width: 10,
            ),
            Expanded(
                child: Text(
              userEntity.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
            InteractionButton(
              content: 'message',
              color: Colors.purpleAccent,
              width: 120,
              height: 35,
              onTap: () {
                context.goNamed(chatScreen,
                    extra: userEntity.profileImageUrl,
                    pathParameters: {
                      'chat_id': userEntity.id!,
                      'name': userEntity.name,
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}

class InteractionButton extends StatefulWidget {
  const InteractionButton(
      {super.key,
      required this.content,
      this.width = 100,
      this.height = 32,
      required this.color,
      this.onTap,
      this.disabled = false});

  final String content;
  final double width;
  final double height;
  final Color color;
  final void Function()? onTap;
  final bool disabled;

  @override
  State<InteractionButton> createState() => _InteractionButtonState();
}

class _InteractionButtonState extends State<InteractionButton> {
  bool buttonGlow = true;

  void setButtonGlowOff(TapDownDetails tapDownDetails) {
    setState(() {
      buttonGlow = false;
    });
  }

  void setButtonGlowOn(TapUpDetails tapUpDetails) {
    setState(() {
      buttonGlow = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.disabled) {
      return GestureDetector(
        onTapUp: setButtonGlowOn,
        onTapDown: setButtonGlowOff,
        onTap: widget.onTap,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              color: widget.color,
              boxShadow: buttonGlow
                  ? [
                      BoxShadow(
                        blurRadius: 11,
                        color: widget.color,
                      )
                    ]
                  : [],
              borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: Text(
            widget.content,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          )),
        ),
      );
    } else {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          widget.content,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        )),
      );
    }
  }
}

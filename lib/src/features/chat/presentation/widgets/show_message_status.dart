import 'package:flutter/material.dart';
import 'package:shuttle/src/core/utils/constants.dart';
import '../../domain/entities/message_entity.dart';

class ShowMessageStatus extends StatelessWidget {
  const ShowMessageStatus({super.key, required this.status});

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    const double iconSize = 7;
    switch (status) {
      case MessageStatus.sent:
        return const Icon(
          Icons.circle,
          color: Colors.red,
          shadows: [
            Shadow(
              blurRadius: 15,
              color: Colors.redAccent,
            ),
          ],
          size: iconSize,
        );
      case MessageStatus.read:
        return const Icon(
          Icons.circle,
          color: actionColor,
          shadows: [
            Shadow(
              blurRadius: 15,
              color: Colors.lightGreenAccent,
            ),
          ],
          size: iconSize,
        );
      default:
        return const Icon(
          Icons.circle,
          shadows: [
            Shadow(
              blurRadius: 15,
              color: Colors.redAccent,
            ),
          ],
          size: iconSize,
        );
    }
  }
}

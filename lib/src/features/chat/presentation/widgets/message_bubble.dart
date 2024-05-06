import 'package:flutter/material.dart';
import 'package:shuttle/src/features/chat/presentation/widgets/show_message_status.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entities/message_entity.dart';

class MessageBubble extends StatelessWidget {
  final String id;
  final MessageEntity messageEntity;
  final bool displayName;

  const MessageBubble(
      {super.key,
      required this.id,
      required this.messageEntity,
      required this.displayName});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.75;
    final DateTime created = DateTime.parse(messageEntity.created);
    return Align(
      alignment: messageEntity.senderId == id
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
        ),
        constraints: BoxConstraints(maxWidth: width, minWidth: 75),
        // The Below Row's main axis alignment doesn't work as column's cross axis alignment is set to start, the content remains in
        // the start position.
        // Instead, the Row is placed on stack.
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (displayName)
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '${messageEntity.senderName}@shuttle:~\$ ',
                        style: const TextStyle(
                          color: Color.fromRGBO(5, 208, 0, 1.0),
                        )),
                    const TextSpan(text: 'echo')
                  ])),
                Text(
                  messageEntity.message,
                ),
                const Text(
                  '',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                // This doesn't work as column's cross axis alignment is set to start, the content remains in
                // the start position.
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${'${created.hour}'.padLeft(2, '0')}:${'${created.minute}'.padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 11, color: actionColor),
                  ),
                  if (messageEntity.senderId != id)
                    const SizedBox(
                      width: 10,
                    ),
                  if (messageEntity.senderId != id)
                    ShowMessageStatus(status: messageEntity.status)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

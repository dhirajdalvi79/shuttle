import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/latest_message_bloc/latest_message_bloc.dart';

class LatestMessageComponent extends StatefulWidget {
  const LatestMessageComponent({super.key, required this.chatId});

  final String chatId;

  @override
  State<LatestMessageComponent> createState() => _LatestMessageComponentState();
}

class _LatestMessageComponentState extends State<LatestMessageComponent> {
  @override
  void initState() {
    super.initState();
    context
        .read<LatestMessageBloc>()
        .add(GetInitialLatestMessageEvent(chatId: widget.chatId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestMessageBloc, LatestMessageState>(
        builder: (BuildContext context, LatestMessageState state) {
      if (state is LatestMessageLoadedState) {
        final DateTime created = DateTime.parse(state.messageEntity.created);

        return Row(
          children: [
            Expanded(
              child: Text(
                state.messageEntity.message,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
                '${'${created.hour}'.padLeft(2, '0')}:${'${created.minute}'.padLeft(2, '0')}')
          ],
        );
      } else if (state is LatestMessageErrorState) {
        return const Text('.....');
      } else {
        return const Text('.....');
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/number_of_message_bloc/number_of_message_bloc.dart';

class NumberOfMessagesIndicator extends StatefulWidget {
  const NumberOfMessagesIndicator({
    super.key,
    required this.chatId,
  });

  final String chatId;

  @override
  State<NumberOfMessagesIndicator> createState() =>
      _NumberOfMessagesIndicatorState();
}

class _NumberOfMessagesIndicatorState extends State<NumberOfMessagesIndicator> {
  @override
  void initState() {
    super.initState();
    context
        .read<NumberOfMessageBloc>()
        .add(GetNumberOfUnreadMessagesEvent(chatId: widget.chatId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberOfMessageBloc, NumberOfMessageState>(
      builder: (BuildContext context, NumberOfMessageState state) {
        if (state is NumberOfUnreadMessagesState) {
          return state.numberOfUnreadMessages != 0
              ? CircleAvatar(
                  backgroundColor: actionColor,
                  radius: 10,
                  child: Text(
                    '${state.numberOfUnreadMessages}',
                    style: const TextStyle(fontSize: 12.5),
                  ),
                )
              : const SizedBox();
        } else if (state is NumberOfUnreadMessagesErrorState) {
          return const SizedBox();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

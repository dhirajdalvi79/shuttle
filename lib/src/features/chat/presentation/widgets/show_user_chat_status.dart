import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/get_app_user_bloc/get_app_user_bloc.dart';
import '../bloc/get_user_chat_status_bloc/get_user_chat_status_bloc.dart';

class ShowUserChatStatus extends StatefulWidget {
  const ShowUserChatStatus({super.key, required this.id});

  final String id;
  final double fontSize = 12;

  @override
  State<ShowUserChatStatus> createState() => _ShowUserChatStatusState();
}

class _ShowUserChatStatusState extends State<ShowUserChatStatus> {
  @override
  void initState() {
    super.initState();
    context.read<GetAppUserBloc>().add(const GetUserEvent());
    context
        .read<GetUserChatStatusBloc>()
        .add(GetUserChatStatusEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAppUserBloc, GetAppUserState>(
      builder: (BuildContext context, GetAppUserState userState) {
        if (userState is LoadedAppUserState) {
          return BlocBuilder<GetUserChatStatusBloc, GetUserChatStatusState>(
            builder: (BuildContext context, GetUserChatStatusState state) {
              if (state is GetUserChatStatusLoadedState) {
                if (state.chatStatusEntity.isOnline) {
                  if (state.chatStatusEntity.typingUser != null) {
                    if (state.chatStatusEntity.typingUser ==
                        userState.userEntity.id!) {
                      return Text(
                        'Typing..',
                        style: TextStyle(fontSize: widget.fontSize),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else {
                    return Text(
                      'Online',
                      style: TextStyle(fontSize: widget.fontSize),
                    );
                  }
                } else {
                  return Text(
                    'Offline',
                    style: TextStyle(fontSize: widget.fontSize),
                  );
                }
              } else if (state is GetUserChatStatusLoadingState) {
                return const SizedBox.shrink();
              } else if (state is GetUserChatStatusErrorState) {
                return const SizedBox.shrink();
              }
              return const SizedBox.shrink();
            },
          );
        } else if (userState is LoadingAppUserState) {
          return const SizedBox.shrink();
        } else if (userState is GetAppUserErrorState) {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}

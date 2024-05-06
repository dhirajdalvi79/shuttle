import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/chat_list_bloc/chat_list_bloc.dart';
import '../../../../app/widgets/circular_loading_indicator.dart';
import '../bloc/chat_status_update_bloc/chat_status_update_bloc.dart';
import '../widgets/chat_card.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context
        .read<ChatStatusUpdateBloc>()
        .add(const UserIsOnlineChatStatusEvent());
    context.read<ChatListBloc>().add(const GetChatListEvent());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        context
            .read<ChatStatusUpdateBloc>()
            .add(const UserIsNotOnlineChatStatusEvent());
        break;
      case AppLifecycleState.resumed:
        context
            .read<ChatStatusUpdateBloc>()
            .add(const UserIsOnlineChatStatusEvent());
        break;
    }
  }

  @override
  void dispose() {
    if (context.mounted) {
      context
          .read<ChatStatusUpdateBloc>()
          .add(const UserIsNotOnlineChatStatusEvent());
    }

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListBloc, ChatListState>(
        builder: (BuildContext context, ChatListState state) {
      if (state is ChatListLoadedState) {
        if (state.chatList.isNotEmpty) {
          return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ChatCard(
                  key: ValueKey(state.chatList[index].id!),
                  chatId: state.chatList[index].id!,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 0,
                  thickness: 0.5,
                  color: Colors.black,
                );
              },
              itemCount: state.chatList.length);
        } else {
          return const Center(child: Text('No Chats'));
        }
      } else if (state is ChatListErrorState) {
        return Center(child: Text(state.message));
      } else if (state is ChatListEmptyState) {
        return const Center(child: Text('No Chats'));
      } else {
        return const CircularLoadingIndicator();
      }
    });
  }
}

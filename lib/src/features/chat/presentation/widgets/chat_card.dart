import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shuttle/src/core/utils/constants.dart';
import 'package:shuttle/src/features/chat/domain/usecases/get_user_name_and_profile_url.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/username_and_profile_image_url_bloc/username_and_profile_image_url_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/number_of_message_bloc/number_of_message_bloc.dart';
import 'package:shuttle/src/routes/route_path_constants.dart';
import '../../../../core/service_locator/injection_container.dart';
import '../../domain/usecases/get_latest_message.dart';
import '../../domain/usecases/get_number_of_unread_messages.dart';
import '../bloc/latest_message_bloc/latest_message_bloc.dart';
import 'latest_message_component.dart';
import 'number_of_message_indicator.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.chatId});

  final String chatId;

  @override
  Widget build(BuildContext context) {
    /// or can be done by initializing ChatBloc i.e. chatBloc = ChatBloc(chatId: chatId) in
    /// initState using state full widget and pass chatBloc bloc
    /// to BlocBuilder for example BlocBuilder<ChatBloc, ChatState>(bloc: chatBloc, builder: ....)
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserNameAndProfileImageUrlBloc(
              getUserNameAndProfileUrl: sl<GetUserNameAndProfileUrl>()),
        ),
        BlocProvider(
          create: (context) =>
              LatestMessageBloc(getLatestMessage: sl<GetLatestMessage>()),
        ),
        BlocProvider(
          create: (context) => NumberOfMessageBloc(
              getNumberOfUnreadMessages: sl<GetNumberOfUnreadMessages>()),
        )
      ],
      child: ChatCardBody(
        chatId: chatId,
      ),
    );
  }
}

class ChatCardBody extends StatefulWidget {
  const ChatCardBody({super.key, required this.chatId});

  final String chatId;

  @override
  State<ChatCardBody> createState() => _ChatCardBodyState();
}

class _ChatCardBodyState extends State<ChatCardBody> {
  @override
  void initState() {
    super.initState();
    context
        .read<UserNameAndProfileImageUrlBloc>()
        .add(GetUserNameAndProfileUrlEvent(chatId: widget.chatId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserNameAndProfileImageUrlBloc,
        UserNameAndProfileImageUrlState>(
      builder: (BuildContext context, UserNameAndProfileImageUrlState state) {
        if (state is UserNameAndProfileImageUrlLoadedState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: state.user['profile_pic'] != null
                      ? NetworkImage(state.user['profile_pic']!)
                      : const AssetImage(profilePicPlaceholder)
                          as ImageProvider,
                  radius: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.goNamed(chatScreen,
                          extra: state.user['profile_pic'],
                          pathParameters: {
                            'chat_id': widget.chatId,
                            'name': state.user['name']!,
                          });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.user['name']!,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            NumberOfMessagesIndicator(
                              chatId: widget.chatId,
                            )
                          ],
                        ),
                        LatestMessageComponent(chatId: widget.chatId)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is UserNameAndProfileUrlErrorState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(profilePicPlaceholder),
                  radius: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.message,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text('.....')
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(profilePicPlaceholder),
                  radius: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('loading')
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

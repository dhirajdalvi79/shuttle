import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shuttle/src/app/widgets/circular_loading_indicator.dart';
import 'package:shuttle/src/core/utils/constants.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/widgets/contact_card.dart';
import 'package:shuttle/src/features/chat/domain/entities/message_entity.dart';
import 'package:shuttle/src/features/chat/domain/usecases/send_message.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/cubit/message_status_update_cubit/message_status_update_cubit.dart';
import '../../../../app/widgets/message_dialog.dart';
import '../../../../core/service_locator/injection_container.dart';
import '../../domain/usecases/delete_messages.dart';
import '../bloc/chat_messages_bloc/chat_messages_bloc.dart';
import '../bloc/chat_status_update_bloc/chat_status_update_bloc.dart';
import '../cubit/message_selection_mode_cubit/message_selection_mode_cubit.dart';
import '../cubit/select_messages_cubit/select_messages_cubit.dart';
import '../widgets/chat_date_separator.dart';
import '../widgets/chat_header_text_style.dart';
import '../widgets/delete_message_confirm_dialog.dart';
import '../widgets/message_bubble.dart';
import '../widgets/show_user_chat_status.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {super.key,
      required this.chatId,
      required this.name,
      required this.profilePic});

  final String chatId;
  final String name;
  final String? profilePic;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/chat_background.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) => sl<ChatMessagesBloc>(),
            ),
            BlocProvider(
              create: (BuildContext context) => sl<SendMessageBloc>(),
            ),
            BlocProvider(
              create: (BuildContext context) => sl<MessageStatusUpdateCubit>(),
            ),
            BlocProvider(
              create: (BuildContext context) => sl<MessageSelectionModeCubit>(),
            ),
            BlocProvider(
              create: (BuildContext context) => sl<SelectMessagesCubit>(),
            ),
          ],
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: BlocBuilder<MessageSelectionModeCubit,
                  MessageSelectionModeState>(
                builder:
                    (BuildContext context, MessageSelectionModeState state) {
                  if (state is MessageSelectionModeOffState) {
                    return AppBar(
                      title: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: profilePic != null
                                ? NetworkImage(profilePic!)
                                : const AssetImage(profilePicPlaceholder)
                                    as ImageProvider,
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Text(
                                    name,
                                    style: chatHeaderTextStyle,
                                  ),
                                  Text(
                                    name,
                                  )
                                ],
                              ),
                              ShowUserChatStatus(
                                id: chatId,
                              )
                            ],
                          ),
                        ],
                      ),
                      titleSpacing: 0,
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.ellipsis_vertical),
                        ),
                      ],
                      backgroundColor: Colors.black,
                    );
                  } else {
                    return AppBar(
                      //title: const Text('testing'),
                      actions: [
                        IconButton(
                          onPressed: () async {
                            final bool result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DeleteMessageConfirmDialog();
                                });
                            if (result) {
                              if (context.mounted) {
                                final SelectMessagesCubit selectMessagesCubit =
                                    context.read<SelectMessagesCubit>();
                                selectMessagesCubit.deleteMessages(
                                    deleteMessagesParameter:
                                        DeleteMessagesParameter(
                                  chatId: chatId,
                                  messageIdSet: selectMessagesCubit.messagesSet,
                                ));
                              }
                            }
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<MessageSelectionModeCubit>()
                                .setMessageSelectionModeOff();
                            context
                                .read<SelectMessagesCubit>()
                                .emptyMessageSet();
                          },
                          icon: const Icon(Icons.cancel),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            body: ChatBody(
              id: chatId,
            ),
          ),
        ),
      ],
    );
  }
}

class ChatBody extends StatefulWidget {
  const ChatBody({super.key, required this.id});

  final String id;

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  late final ChatMessagesBloc _chatMessagesBloc;
  late final TextEditingController _messageFieldController;

  @override
  void initState() {
    super.initState();

    _chatMessagesBloc = context.read<ChatMessagesBloc>();
    _chatMessagesBloc.add(GetMessagesEvent(id: widget.id));
    _messageFieldController = TextEditingController();
    _messageFieldController.addListener(_updateTypingState);
    context
        .read<ChatStatusUpdateBloc>()
        .add(const UserIsOnlineChatStatusEvent());
  }

  void _updateTypingState() {
    if (_messageFieldController.text.isNotEmpty) {
      context
          .read<ChatStatusUpdateBloc>()
          .add(UserIsTypingChatStatusEvent(id: widget.id));
    } else if (_messageFieldController.text.isEmpty) {
      context
          .read<ChatStatusUpdateBloc>()
          .add(const UserIsNotTypingChatStatusEvent());
    }
  }

  void _sendMessage() {
    if (_messageFieldController.text.isNotEmpty) {
      final MessageEntity messageEntity = MessageEntity(
          message: _messageFieldController.text.trim(),
          created: DateTime.now().toIso8601String());
      final SendMessageParameter sendMessageParameter = SendMessageParameter(
          messageEntity: messageEntity, otherUserId: widget.id);
      context.read<SendMessageBloc>().add(
          SendTextMessageEvent(sendMessageParameter: sendMessageParameter));
      _messageFieldController.clear();
    }
  }

  void selectDeselectMessage({required String messageId}) {
    if (context.read<MessageSelectionModeCubit>().state
        is MessageSelectionModeOnState) {
      final SelectMessagesCubit selectMessagesCubit =
          context.read<SelectMessagesCubit>();
      if (selectMessagesCubit.messagesSet.contains(messageId)) {
        selectMessagesCubit.deselectMessage(messageId: messageId);
      } else {
        selectMessagesCubit.selectMessage(messageId: messageId);
      }
    }
  }

  @override
  void dispose() {
    _messageFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatMessagesBloc, ChatMessagesState>(
            bloc: _chatMessagesBloc,
            builder: (context, state) {
              if (state is ChatMessagesLoadedState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context
                      .read<MessageStatusUpdateCubit>()
                      .updateMessageStatus(id: widget.id);
                });

                return BlocListener<SelectMessagesCubit, SelectMessagesState>(
                  listener: (BuildContext context, SelectMessagesState state) {
                    if (state is DeleteMessagesLoadingState) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CircularLoadingIndicator();
                          });
                    } else if (state is DeleteMessagesErrorState) {
                      context.pop();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MessageDialog(message: state.message);
                          });
                    } else if (state is DeletedMessagesSuccessState) {
                      context.pop();
                      context
                          .read<MessageSelectionModeCubit>()
                          .setMessageSelectionModeOff();
                    }
                  },
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemBuilder: (BuildContext context, int index) {
                          MessageEntity messageEntity = MessageEntity(
                            id: state.messages[index].id,
                            message: state.messages[index].message,
                            created: state.messages[index].created,
                            senderId: state.messages[index].senderId,
                            senderName: state.messages[index].senderName,
                            status: state.messages[index].status,
                          );
                          /*  For reverse: false
                        final bool showSenderName = index == 0 || state.messages[index - 1].senderName != messageEntity.senderName;*/
                          /*
                        For reverse: true and without date display between messages
                        final bool showSenderName =
                            index == state.messages.length - 1 ||
                                state.messages[index + 1].senderName !=
                                    messageEntity.senderName;                    */
                          if (index == state.messages.length - 1) {
                            return Column(
                              children: [
                                DateSeparator(
                                    dateTime: DateTime.parse(
                                        state.messages[index].created)),
                                GestureDetector(
                                  onLongPress: () {
                                    context
                                        .read<MessageSelectionModeCubit>()
                                        .setMessageSelectionModeOn();
                                    selectDeselectMessage(
                                        messageId: state.messages[index].id!);
                                  },
                                  onTap: () {
                                    selectDeselectMessage(
                                        messageId: state.messages[index].id!);
                                  },
                                  child: Stack(
                                    children: [
                                      MessageBubble(
                                        key: ValueKey(state.messages[index].id),
                                        id: widget.id,
                                        displayName: true,
                                        messageEntity: messageEntity,
                                      ),
                                      BlocBuilder<SelectMessagesCubit,
                                          SelectMessagesState>(
                                        builder: (BuildContext context,
                                            SelectMessagesState
                                                selectMessagesState) {
                                          if (selectMessagesState
                                              is SelectedMessagesSet) {
                                            if (selectMessagesState
                                                .selectedMessages
                                                .contains(
                                                    state.messages[index].id)) {
                                              return Positioned.fill(
                                                child: Container(
                                                  width: double.infinity,
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 0.2),
                                                ),
                                              );
                                            }
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          final bool showSenderName =
                              state.messages[index + 1].senderName !=
                                  messageEntity.senderName;
                          return GestureDetector(
                            onLongPress: () {
                              context
                                  .read<MessageSelectionModeCubit>()
                                  .setMessageSelectionModeOn();
                              selectDeselectMessage(
                                  messageId: state.messages[index].id!);
                            },
                            onTap: () {
                              selectDeselectMessage(
                                  messageId: state.messages[index].id!);
                            },
                            child: Stack(
                              children: [
                                MessageBubble(
                                  key: ValueKey(state.messages[index].id),
                                  id: widget.id,
                                  displayName: showSenderName,
                                  messageEntity: messageEntity,
                                ),
                                BlocBuilder<SelectMessagesCubit,
                                    SelectMessagesState>(
                                  builder: (BuildContext context,
                                      SelectMessagesState selectMessagesState) {
                                    if (selectMessagesState
                                        is SelectedMessagesSet) {
                                      if (selectMessagesState.selectedMessages
                                          .contains(state.messages[index].id)) {
                                        return Positioned.fill(
                                          child: Container(
                                            width: double.infinity,
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.2),
                                          ),
                                        );
                                      }
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          DateTime nextDate =
                              DateTime.parse(state.messages[index + 1].created);
                          nextDate = DateTime(
                              nextDate.year, nextDate.month, nextDate.day);
                          DateTime currentDate =
                              DateTime.parse(state.messages[index].created);
                          currentDate = DateTime(currentDate.year,
                              currentDate.month, currentDate.day);
                          final bool showDateSeparator =
                              nextDate != currentDate;
                          /*
                        For reverse: true
                         final bool showDateSeparator =
                            index == state.messages.length - 1 ||
                                DateTime.parse(state.messages[index + 1].created) !=
                                    DateTime.parse(state.messages[index].created);*/
                          if (showDateSeparator) {
                            return DateSeparator(
                              dateTime: currentDate,
                            );
                          } else {
                            return const SizedBox(
                              height: 7,
                            );
                          }
                        },
                        itemCount: state.messages.length),
                  ),
                );
              } else if (state is ChatMessagesLoadingState) {
                return const CircularLoadingIndicator();
              } else if (state is ChatMessagesErrorState) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const Center(
                child: Text(''),
              );
            },
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Container(
          // height: 58,
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: Row(
            children: [
              Expanded(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextField(
                  controller: _messageFieldController,
                  maxLines: 5,
                  minLines: 1,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.emoji_emotions_outlined),
                      hintText: 'Message',
                      border: InputBorder.none,
                      fillColor: Colors.white10,
                      filled: true),
                ),
              )),
              const SizedBox(
                width: 9,
              ),
              InteractionButton(
                content: 'Send',
                color: Colors.purpleAccent,
                width: 55,
                height: 38,
                onTap: _sendMessage,
              )
            ],
          ),
        )
      ],
    );
  }
}

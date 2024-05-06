import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/widgets/circular_loading_indicator.dart';
import '../../../../app/widgets/message_dialog.dart';
import '../../../../core/utils/constants.dart';
import '../../../../routes/route_path_constants.dart';
import '../bloc/add_to_contact_bloc/add_to_contact_bloc.dart';
import '../bloc/contact_exists_bloc/contact_exists_bloc.dart';
import '../bloc/get_contacts_bloc/get_contacts_bloc.dart';
import 'contact_card.dart';

class ProfileButtonSet extends StatefulWidget {
  const ProfileButtonSet(
      {super.key,
      required this.id,
      required this.nameOfUser,
      required this.userProfilePic});

  final String id;
  final String nameOfUser;
  final String? userProfilePic;

  @override
  State<ProfileButtonSet> createState() => _ProfileButtonSetState();
}

class _ProfileButtonSetState extends State<ProfileButtonSet> {
  late final ContactExistsBloc _contactExistsBloc;

  @override
  void initState() {
    super.initState();
    _contactExistsBloc = context.read<ContactExistsBloc>();
    _contactExistsBloc.add(CheckContactExistsEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToContactBloc, AddToContactState>(
      listener: (context, state) {
        if (state is AddToContactSuccessState) {
          context.pop();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialog(message: state.message);
              });
        } else if (state is AddToContactFailureState) {
          context.pop();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialog(message: state.message);
              });
        } else if (state is AddToContactLoadingState) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CircularLoadingIndicator();
              });
        }
      },
      child: BlocBuilder<ContactExistsBloc, ContactExistsState>(
          bloc: _contactExistsBloc,
          builder: (BuildContext context, ContactExistsState state) {
            if (state is LoadedContactExistsState) {
              if (state.contactExists) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const InteractionButton(
                      content: 'call',
                      color: actionColor,
                      width: 120,
                      height: 35,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InteractionButton(
                      content: 'message',
                      color: Colors.purpleAccent,
                      width: 120,
                      height: 35,
                      onTap: () {
                        context.goNamed(chatScreen,
                            extra: widget.userProfilePic,
                            pathParameters: {
                              'chat_id': widget.id,
                              'name': widget.nameOfUser,
                            });
                      },
                    ),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const InteractionButton(
                      content: 'call',
                      color: actionColor,
                      width: 120,
                      height: 35,
                      disabled: true,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InteractionButton(
                      content: 'add contacts',
                      color: Colors.purpleAccent,
                      width: 120,
                      height: 35,
                      onTap: () {
                        context
                            .read<AddToContactBloc>()
                            .add(AddToContactEvent(id: widget.id));
                        _contactExistsBloc
                            .add(CheckContactExistsEvent(id: widget.id));
                        context
                            .read<GetContactsBloc>()
                            .add(const GetContactsEvent());
                      },
                    ),
                  ],
                );
              }
            } else if (state is ContactExistsErrorState) {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InteractionButton(
                    content: '...',
                    color: actionColor,
                    width: 120,
                    height: 35,
                    disabled: true,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  InteractionButton(
                    content: '...',
                    color: Colors.purpleAccent,
                    width: 120,
                    height: 35,
                    disabled: true,
                  ),
                ],
              );
            } else {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InteractionButton(
                    content: '...',
                    color: actionColor,
                    width: 120,
                    height: 35,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  InteractionButton(
                    content: '...',
                    color: Colors.purpleAccent,
                    width: 120,
                    height: 35,
                  ),
                ],
              );
            }
          }),
    );
  }
}

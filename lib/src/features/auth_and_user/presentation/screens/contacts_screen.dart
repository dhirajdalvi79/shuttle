import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shuttle/src/app/widgets/circular_loading_indicator.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/widgets/contact_card.dart';
import 'package:shuttle/src/routes/route_path_constants.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/get_contacts_bloc/get_contacts_bloc.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crewmates',
          style: TextStyle(
            color: actionColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: GestureDetector(
              onTap: () async {
                context.goNamed(exploreScreen);
              },
              child: const Icon(
                CupertinoIcons.person_add_solid,
                color: actionColor,
              ),
            ),
          ),
        ],
      ),
      body: const ContactsScreenBody(),
    );
  }
}

class ContactsScreenBody extends StatefulWidget {
  const ContactsScreenBody({super.key});

  @override
  State<ContactsScreenBody> createState() => _ContactsScreenBodyState();
}

class _ContactsScreenBodyState extends State<ContactsScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<GetContactsBloc>().add(const GetContactsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetContactsBloc, ContactsState>(
        builder: (BuildContext context, ContactsState state) {
      if (state is LoadedContacts) {
        if (state.contacts.isNotEmpty) {
          return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ContactCard(
                  userEntity: state.contacts[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 0,
                  thickness: 0.5,
                  color: Colors.black,
                );
              },
              itemCount: state.contacts.length);
        } else {
          return const Center(child: Text('No Crewmates'));
        }
      } else if (state is LoadingContacts) {
        return const CircularLoadingIndicator();
      } else if (state is GetContactsError) {
        return Center(child: Text(state.message));
      } else {
        return const Center(
            child: Text('Something went wrong or empty contacts'));
      }
    });
  }
}

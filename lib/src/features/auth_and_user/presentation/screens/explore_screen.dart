import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/bloc/all_users_bloc/all_users_bloc.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/widgets/explore_card.dart';
import '../../../../app/widgets/circular_loading_indicator.dart';
import '../../../../core/utils/constants.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
            color: actionColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: GestureDetector(
              onTap: () async {},
              child: const Icon(
                CupertinoIcons.search,
                color: actionColor,
              ),
            ),
          ),
        ],
      ),
      body: const ExploreScreenBody(),
    );
  }
}

class ExploreScreenBody extends StatefulWidget {
  const ExploreScreenBody({super.key});

  @override
  State<ExploreScreenBody> createState() => _ExploreScreenBodyState();
}

class _ExploreScreenBodyState extends State<ExploreScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<AllUsersBloc>().add(const GetAllUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllUsersBloc, AllUsersState>(
        builder: (BuildContext context, AllUsersState state) {
      if (state is LoadedAllUsersState) {
        if (state.users.isNotEmpty) {
          return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ExploreCard(
                  userEntity: state.users[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 0,
                  thickness: 0.5,
                  color: Colors.black,
                );
              },
              itemCount: state.users.length);
        } else {
          return const Center(child: Text('No Users'));
        }
      } else if (state is LoadingAllUsersState) {
        return const CircularLoadingIndicator();
      } else if (state is GetAllUsersErrorState) {
        return Center(child: Text(state.message));
      } else {
        return const Center(
            child: Text('Something went wrong or empty contacts'));
      }
    });
  }
}

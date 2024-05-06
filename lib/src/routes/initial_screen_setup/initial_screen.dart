import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../route_path_constants.dart';
import 'initial_screen_bloc.dart';
import 'loading_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InitialScreenBloc, InitialScreenAuthState>(
        listener: (BuildContext context, InitialScreenAuthState state) {
          if (state is LoggedOutState) {
            context.goNamed(logIn);
          } else if (state is LoggedInState) {
            context.goNamed(homeScreen);
          }
        },
        child: const LoadingScreen());
  }
}

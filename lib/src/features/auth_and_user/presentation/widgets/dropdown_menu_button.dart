import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shuttle/src/routes/route_path_constants.dart';
import '../../../../app/widgets/circular_loading_indicator.dart';
import '../../../../app/widgets/message_dialog.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/auth_bloc/auth_bloc.dart';

class DropDownMenuButton extends StatelessWidget {
  const DropDownMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthLoading) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CircularLoadingIndicator();
              });
        } else if (state is LogoutSuccess) {
          context.goNamed(logIn);
        } else if (state is LogoutFailure) {
          context.pop();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialog(message: state.message);
              });
        }
      },
      child: DropdownButton(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          icon: const Icon(
            CupertinoIcons.ellipsis_vertical,
            color: actionColor,
          ),
          underline: const Divider(
            color: Colors.transparent,
            height: 0, // Set height to 0 to completely remove the line
          ),
          items: const [
            DropdownMenuItem(
              value: 0,
              child: Text('Account'),
            ),
            DropdownMenuItem(
              value: 1,
              child: Text('Settings'),
            ),
            DropdownMenuItem(
              value: 2,
              child: Text('Log out'),
            ),
          ],
          onChanged: (value) {
            switch (value) {
              case 0:
                break;
              case 1:
                break;
              case 2:
                context.read<AuthBloc>().add(const LogOutEvent());
                break;
            }
          }),
    );
  }
}

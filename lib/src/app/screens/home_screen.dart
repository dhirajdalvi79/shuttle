import 'package:flutter/material.dart';
import 'package:shuttle/src/features/chat/presentation/screens/chat_list_screen.dart';
import '../../core/utils/constants.dart';
import '../../features/auth_and_user/presentation/widgets/dropdown_menu_button.dart';
import '../widgets/floating_action_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Shuttle',
              style: TextStyle(
                color: actionColor,
              ),
            ),
          ),
          actions: const [
            DropDownMenuButton(),
          ],
        ),
      ),
      body: const ChatListScreen(),
      floatingActionButton: const AppFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

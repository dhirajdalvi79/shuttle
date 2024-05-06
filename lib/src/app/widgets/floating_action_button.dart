import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shuttle/src/routes/route_path_constants.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(contactsScreen),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.green,
            boxShadow: const [
              BoxShadow(
                blurRadius: 11,
                color: Colors.green,
              )
            ],
            borderRadius: BorderRadius.circular(100)),
        child: const Center(child: Icon(Icons.contacts)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/constants.dart';

class DeleteMessageConfirmDialog extends StatelessWidget {
  const DeleteMessageConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Dialog(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Delete Messages?',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          context.pop(true);
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                              color: actionColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () {
                          context.pop(false);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              color: actionColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shuttle/src/core/utils/constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
            color: actionColor, strokeWidth: 7, strokeAlign: 7),
      ),
    );
  }
}

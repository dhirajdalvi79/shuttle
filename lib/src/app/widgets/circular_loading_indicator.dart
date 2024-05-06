import 'package:flutter/material.dart';
import '../../core/utils/constants.dart';

class CircularLoadingIndicator extends StatelessWidget {
  const CircularLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      type: MaterialType.transparency,
      child: Center(
          child: SizedBox(
              height: 70,
              width: 70,
              child: CircularProgressIndicator(
                color: actionColor,
              ))),
    );
  }
}

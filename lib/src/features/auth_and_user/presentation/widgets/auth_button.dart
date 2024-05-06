import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const AuthButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(
          Colors.white70,
        ),
        shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
        fixedSize: MaterialStatePropertyAll<Size>(Size(190, 42)),
        maximumSize: MaterialStatePropertyAll<Size>(Size(190, 42)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
      ),
    );
  }
}

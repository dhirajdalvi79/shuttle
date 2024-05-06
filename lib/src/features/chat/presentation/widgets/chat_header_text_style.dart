import 'package:flutter/material.dart';

TextStyle chatHeaderTextStyle = TextStyle(
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.greenAccent,
    shadows: const [
      Shadow(
        blurRadius: 30,
        color: Colors.greenAccent,
      ),
      Shadow(
        blurRadius: 30,
        color: Colors.greenAccent,
      )
    ]);

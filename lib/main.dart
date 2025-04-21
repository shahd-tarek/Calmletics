import 'package:flutter/material.dart';
import 'package:sports_mind/calm%20routine/box_breathing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BoxBreathingScreen(),
    );
  }
}

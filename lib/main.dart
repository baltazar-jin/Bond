import 'package:flutter/material.dart';
import 'package:bond_v2/views/welcomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bond',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF87E04),
          primary: const Color(0xFFF87E04),
          secondary: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}
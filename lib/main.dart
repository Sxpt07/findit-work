import 'package:flutter/material.dart';
import 'features/auth/screens/login_screen.dart';

void main() => runApp(const WorkerApp());

class WorkerApp extends StatelessWidget {
  const WorkerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FindIt! Worker',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF00236F), useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}
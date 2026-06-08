import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const AICyberShieldApp());
}

class AICyberShieldApp extends StatelessWidget {
  const AICyberShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI CyberShield',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0A0F1C),
      ),
      home: const SplashScreen(),
    );
  }
}
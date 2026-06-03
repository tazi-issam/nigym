import 'package:flutter/material.dart';
import 'onboarding_screen.dart'; // Import de ton onboarding actuel

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ni-Gym',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const OnboardingScreen(), // Lance ton écran onboarding inchangé
    );
  }
}
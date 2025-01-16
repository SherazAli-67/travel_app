import 'package:flutter/material.dart';
import 'package:travel_app/src/res/app_colors.dart';
import 'package:travel_app/src/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traver App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
        fontFamily: 'Poppins'
      ),
      home: const WelcomePage()
    );
  }
}

import 'package:flutter/material.dart';
import 'Home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
        primaryColor: const Color(0xff120D26),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          actionsIconTheme: IconThemeData(
            size: 24,
          ),
          titleTextStyle: TextStyle(color: Color(0xff120D26), fontSize: 24),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff5669FF)),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

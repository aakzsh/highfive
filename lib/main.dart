import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';
import 'package:highfive/screens.dart/chat.dart';
import 'package:highfive/screens.dart/home.dart';
import 'package:highfive/screens.dart/join_room.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

bool isTeacher = true;

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "High-Five",
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: AppColors.bg,
          brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: const JoinRoom(),
    );
  }
}

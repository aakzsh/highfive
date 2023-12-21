import 'package:flutter/material.dart';
import 'package:highfive/constants/helper.dart';
import 'package:highfive/services/shared_preferences.dart';
import 'package:highfive/views/connection.dart';
import 'package:highfive/views/welcome.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isStart = true;
  @override
  void initState() {
    super.initState();
    SharedPref().getRole().then((value) => {
          if (value == "teacher" || value == "student")
            {
              setState(() {
                isStart = false;
              })
            },
          log(value.toString())
        });
    SharedPref().setDownloadedFiles();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: Helper.title,
      home: isStart ? const WelcomeScreen() : const Connection(),
    );
  }
}

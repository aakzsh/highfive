import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';

class Message extends StatelessWidget {
  const Message(
      {super.key,
      required this.content,
      required this.datetime,
      required this.name});

  final String name;
  final String content;
  final DateTime datetime;

  @override
  Widget build(BuildContext context) {
    List<Color> nameColors = [
      Color.fromARGB(255, 235, 127, 44),
      Color.fromARGB(255, 101, 235, 44),
      Color.fromARGB(255, 44, 143, 235),
      Color.fromARGB(255, 211, 65, 255),
      Color.fromARGB(255, 250, 71, 71),
      Color.fromARGB(255, 255, 216, 59),
    ];
    return ListTile(
      title: Text(
        name,
        style: TextStyle(color: getNewColor(nameColors)),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Text(
          content,
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      trailing:
          Text("${datetime.hour.toString()}:${datetime.minute.toString()}"),
    );
  }
}

Color getNewColor(nameColors) {
  nameColors.shuffle();
  return nameColors[0];
}

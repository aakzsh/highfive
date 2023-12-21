import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox(
      {super.key,
      required this.content,
      required this.author,
      required this.username,
      required this.time});
  final String content;
  final String author;
  final String username;
  final String time;

  @override
  Widget build(BuildContext context) {
    return author != username
        ? Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author,
                  style: const TextStyle(fontSize: 11),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.purple[50],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          time,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black54),
                        ),
                        Text(content),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "me",
                  style: TextStyle(fontSize: 11),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red[50],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          time,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black54),
                        ),
                        Text(content),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

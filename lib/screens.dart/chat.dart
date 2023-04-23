import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back),
        title: const Text("Chat"),
        actions: const [
          Center(
            child: Text(
              "Wayne's Class",
              style: TextStyle(color: Colors.white54),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.lightBlue,
            )),
            const SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.imageGrey),
                height: 50,
                width: double.maxFinite,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: "Type a message.."),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';
import 'package:highfive/constants/message_widget.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, String>> chats = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text("Chat"),
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                "Wayne's Class",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    reverse: true,
                    itemCount: 3,
                    itemBuilder: ((context, index) => Message(
                        content: "hello just checking",
                        datetime: DateTime.now(),
                        name: "Amanda")))),
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

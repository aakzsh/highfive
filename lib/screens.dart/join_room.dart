import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';
import 'package:highfive/screens.dart/create_room.dart';

class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/createroom.png",
              scale: 4,
            ),
            Column(
              children: const [
                TextField(
                  decoration: InputDecoration(hintText: "Enter Your Name"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Room ID"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Password"),
                ),
              ],
            ),
            Column(
              children: [
                MaterialButton(
                  onPressed: () {},
                  color: AppColors.accentGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minWidth: double.maxFinite,
                  height: 60,
                  child: const Text(
                    "Join Room",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const CreateRoom())),
                        (route) => false);
                  },
                  child: const Text(
                    "Create a New Room",
                    style:
                        TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}

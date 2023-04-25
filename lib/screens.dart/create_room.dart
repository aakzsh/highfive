import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';
import 'package:highfive/main.dart';
import 'package:highfive/screens.dart/home.dart';
import 'package:highfive/screens.dart/join_room.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
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
              "assets/images/joinroom.png",
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
                  decoration: InputDecoration(hintText: "Create Password"),
                ),
              ],
            ),
            Column(
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      isTeacher = true;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  },
                  color: AppColors.accentGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minWidth: double.maxFinite,
                  height: 60,
                  child: const Text(
                    "Create Room",
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
                            builder: ((context) => const JoinRoom())),
                        (route) => false);
                  },
                  child: const Text(
                    "Join a Room",
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

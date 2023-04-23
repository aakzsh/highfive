import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';
import 'package:highfive/screens.dart/chat.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  bool firstSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: AppColors.accentGreen,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => const Chat())));
        },
        child: Image.asset(
          "assets/icons/message.png",
          height: 30,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back),
        title: const Text("Wayne's Class"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        firstSelected = true;
                      });
                    },
                    height: 40,
                    color: firstSelected
                        ? AppColors.accentGreen
                        : AppColors.imageGrey,
                    child: const Text("Students"),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        firstSelected = false;
                      });
                    },
                    height: 40,
                    color: !firstSelected
                        ? AppColors.accentGreen
                        : AppColors.imageGrey,
                    child: const Text("Activity"),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            firstSelected
                ? Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: ((context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${index + 1}: frooti",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                  const Icon(
                                    Icons.remove_circle_outline_outlined,
                                    color: Color.fromARGB(255, 255, 129, 120),
                                  )
                                ],
                              ),
                            ))))
                : Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [Text("Files"), Icon(Icons.add)],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 120,
                        color: AppColors.imageGrey,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [Text("Polls"), Icon(Icons.add)],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 120,
                        color: AppColors.imageGrey,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Announcements"),
                          Icon(Icons.add)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 120,
                        color: AppColors.imageGrey,
                        child: const Center(
                          child: Text(
                            "No Announcements Yet",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: AppColors.textSecondary),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  )))
          ],
        ),
      ),
    );
  }
}

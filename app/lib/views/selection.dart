import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';
import 'package:highfive/constants/helper.dart';
import 'package:highfive/services/shared_preferences.dart';
import 'package:highfive/views/connection.dart';

class Selection extends StatefulWidget {
  const Selection({super.key});

  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  String username = "";

  setName(name) {
    setState(() {
      username = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
            width: double.maxFinite,
          ),
          Image.asset(
            Helper.applogopath,
            scale: 4,
          ),
          Container(
            width: 240,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.lightblue,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: (value) => setName(value),
                  decoration: const InputDecoration(
                    hintText: Helper.enterName,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              const Text(
                Helper.joinAs,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () async {
                  if (username.isEmpty) {
                    showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: const Text(
                                "Wrong Input!",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              content: const Text(
                                  "Please put the name in the textfield. Empty name field isn't allowed!"),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Close"),
                                )
                              ],
                            )));
                  } else {
                    await SharedPref().storeRole("student");
                    await SharedPref().storeUsername(username).then((value) => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const Connection())))
                        });
                  }
                },
                minWidth: 240,
                height: 45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: AppColors.blue,
                child: const Text(
                  Helper.student,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(Helper.or),
              const SizedBox(
                height: 5,
              ),
              MaterialButton(
                onPressed: () async {
                  if (username.isEmpty) {
                    showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: const Text(
                                "Wrong Input!",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              content: const Text(
                                  "Please put the name in the textfield. Empty name field isn't allowed!"),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Close"),
                                )
                              ],
                            )));
                  } else {
                    await SharedPref().storeRole("teacher");
                    await SharedPref().storeUsername(username).then((value) =>
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Connection()))));
                  }
                },
                minWidth: 240,
                height: 45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: AppColors.blue,
                child: const Text(
                  Helper.teacher,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      )),
    );
  }
}

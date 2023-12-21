import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';
import 'package:highfive/constants/helper.dart';
import 'package:highfive/services/api.dart';
import 'package:highfive/services/shared_preferences.dart';
import 'package:highfive/views/welcome.dart';
import 'package:highfive/widgets/header.dart';
import 'package:highfive/widgets/message_box.dart';
import 'package:open_filex/open_filex.dart';

class NormalContent extends StatefulWidget {
  const NormalContent({super.key});
  @override
  State<NormalContent> createState() => _NormalContentState();
}

class _NormalContentState extends State<NormalContent> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _announcementController = TextEditingController();

  late Timer _timer;
  List<dynamic> announcements = [];
  List<dynamic> messages = [];
  List<dynamic> files = [];
  String chatval = "";
  String username = "XYZ";
  String role = "student";
  List<String> downloadedFiles = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchData();
    });
    SharedPref().getRole().then((value) => {
          setState(() {
            role = value ?? "student";
          })
        });
    SharedPref().getUsername().then((value) => {
          setState(() {
            username = value ?? "student";
          })
        });
    SharedPref().getDownloadedFiles().then((value) => {
          if (value != Null)
            {
              setState(() {
                downloadedFiles = value ?? [];
              })
            }
        });
  }

  void cancelFetching() {
    _timer.cancel();
  }

  Future<void> fetchData() async {
    log("called fetch data");
    var res1 = await getChats();
    setState(() {
      messages = res1["texts"];
    });

    var res2 = await getFiles();
    setState(() {
      files = res2;
    });

    var res3 = await getAnnouncements();
    setState(() {
      announcements = res3["announcements"];
    });
  }

  @override
  void dispose() {
    cancelFetching();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title: Helper.home),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: FutureBuilder<String?>(
            future: SharedPref().getUsernameAndRole(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // setState(() {
                //   username = snapshot.data!.split(",")[0];
                // });
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hey ${snapshot.data!.split(",")[0]} 👋\nYour profile is set to ${snapshot.data!.split(",")[1]}",
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        SharedPref().clearAll().then((value) => {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const WelcomeScreen())),
                                  (route) => false)
                            });
                      },
                      minWidth: 100,
                      height: 30,
                      color: AppColors.blue,
                      child: const Center(
                        child: Text(
                          "Exit Room",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return const Text('Error retrieving Role');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Announcements",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.blue),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Container(
                    color: AppColors.lightblue,
                    child: ListView.builder(
                      itemCount: announcements.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                announcements[index]["datetime"]!,
                                style: const TextStyle(fontSize: 9),
                              ),
                              Text(announcements[index]["content"]!)
                            ],
                          ),
                        );
                      },
                    ),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  role == "teacher"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title:
                                            const Text("Add your announcement"),
                                        content: TextField(
                                          controller: _announcementController,
                                          decoration: const InputDecoration(
                                              hintText: "Type here"),
                                        ),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              var res = await sendAnnouncements(
                                                  _announcementController.text);
                                              setState(() {
                                                announcements =
                                                    res["announcements"];
                                              });
                                              _announcementController.clear();
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Post"),
                                          )
                                        ],
                                      ));
                            },
                            color: AppColors.blue,
                            height: 50,
                            minWidth: double.maxFinite,
                            child: const Text(
                              "Post New Announcement",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  const Text(
                    "Files and Attachments",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.blue),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Container(
                    color: AppColors.lightblue,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () async {
                              if (downloadedFiles.contains(files[index])) {
                                OpenFilex.open(
                                    "/storage/emulated/0/Download/${files[index]}");
                              } else {
                                await downloadFile(files[index]);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'File Downloaded Succefully in Local Storage'),
                                ));
                                var res =
                                    await SharedPref().getDownloadedFiles();
                                setState(() {
                                  downloadedFiles = res!;
                                });
                                // print("res is $res");
                              }
                              // log(res);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green[50],
                                  ),
                                  child: Center(
                                    child:
                                        downloadedFiles.contains(files[index])
                                            ? Image.asset(
                                                "assets/tick.png",
                                                scale: 4,
                                              )
                                            : Image.asset(
                                                "assets/download.png",
                                                scale: 4,
                                              ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(files[index].length > 12
                                    ? "${files[index].toString().substring(0, 10)}.."
                                    : files[index].toString())
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  role == "teacher"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: MaterialButton(
                            onPressed: () async {
                              var res = await uploadFile();
                              log(res);
                              // _scaff
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('File Uploaded Succefully!'),
                              ));
                            },
                            color: AppColors.blue,
                            height: 50,
                            minWidth: double.maxFinite,
                            child: const Text(
                              "Upload New File",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  const Text(
                    "Chat",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.blue),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Container(
                    color: AppColors.lightblue,
                    child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MessageBox(
                              content: messages[index]["content"]!,
                              author: messages[index]["author"]!,
                              username: username,
                              time: messages[index]["datetime"]!),
                        );
                        // return Text(messages[index]["content"]!);
                      },
                    ),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.lightblue,
                    ),
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 90,
                                child: TextField(
                                  controller: _controller,
                                  onChanged: (value) {
                                    setState(() {
                                      chatval = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Type here...",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Image.asset(
                                  "assets/send.png",
                                  scale: 4,
                                ),
                                onTap: () async {
                                  if (chatval.isNotEmpty) {
                                    var res = await sendChat(chatval, username);
                                    log(res.toString());
                                    setState(() {
                                      messages = res["texts"];
                                    });
                                    _controller.clear();
                                  } else {
                                    log("less length");
                                    _controller.clear();
                                  }
                                },
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              )),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

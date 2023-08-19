import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';
import 'package:highfive/main.dart';
import 'package:highfive/screens.dart/chat.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TcpSocketConnection socketConnection =
      TcpSocketConnection("192.168.1.113", 10251);

  String message = "";

  @override
  void initState() {
    super.initState();
    startConnection();
  }

  //receiving and sending back a custom message
  void messageReceived(String msg) {
    setState(() {
      message = msg;
    });
    socketConnection.sendMessage("MessageIsReceived :D ");
  }

  //starting the connection and listening to the socket asynchronously
  void startConnection() async {
    print("starting");
    socketConnection.enableConsolePrint(
        true); //use this to see in the console what's happening
    if (await socketConnection.canConnect(5000, attempts: 3)) {
      //check if it's possible to connect to the endpoint
      await socketConnection.connect(5000, messageReceived, attempts: 3);
    }
  }
  ////////////////////////////////

  bool firstSelected = true;
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
        leading: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                      "Are you sure you want to exit the classroom?"),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: const Color.fromARGB(255, 245, 84, 81),
                      minWidth: 100,
                      height: 40,
                      child: const Text("No"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const App())),
                            (route) => false);
                      },
                      color: AppColors.accentGreen,
                      minWidth: 100,
                      height: 40,
                      child: const Text("Yes"),
                    )
                  ],
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Wayne's Class"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'You have received $message',
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: GestureDetector(
                                onLongPress: () {
                                  isTeacher
                                      ? showDialog(
                                          context: context,
                                          builder: ((context) => AlertDialog(
                                                title: const Text(
                                                    "Remove frooti from class?"),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    color: const Color.fromARGB(
                                                        255, 245, 84, 81),
                                                    minWidth: 100,
                                                    height: 40,
                                                    child: const Text("No"),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    color:
                                                        AppColors.accentGreen,
                                                    minWidth: 100,
                                                    height: 40,
                                                    child: const Text("Yes"),
                                                  )
                                                ],
                                              )))
                                      : print("no access");
                                },
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
                                  ],
                                ),
                              ),
                            ))))
                : Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Files"),
                          isTeacher
                              ? IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: ((context) => AlertDialog(
                                              title: const Text(
                                                  "Add your files here"),
                                              content: TextFormField(
                                                maxLines: 1,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Type here..."),
                                              ),
                                              actions: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  color: AppColors.accentGreen,
                                                  minWidth: 100,
                                                  height: 40,
                                                  child: const Text("Send"),
                                                )
                                              ],
                                            )));
                                  },
                                )
                              : const SizedBox()
                        ],
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
                        children: [
                          const Text("Polls"),
                          isTeacher
                              ? IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: ((context) => AlertDialog(
                                              title: const Text(
                                                  "Add your poll here"),
                                              content: TextFormField(
                                                maxLines: 1,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Type here..."),
                                              ),
                                              actions: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  color: AppColors.accentGreen,
                                                  minWidth: 100,
                                                  height: 40,
                                                  child: const Text("Send"),
                                                )
                                              ],
                                            )));
                                  },
                                )
                              : const SizedBox()
                        ],
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
                        children: [
                          const Text("Announcements"),
                          isTeacher
                              ? IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: ((context) => AlertDialog(
                                              title: const Text(
                                                  "Add your announcement text here"),
                                              content: TextFormField(
                                                maxLines: 1,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Type here..."),
                                              ),
                                              actions: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  color: AppColors.accentGreen,
                                                  minWidth: 100,
                                                  height: 40,
                                                  child: const Text("Send"),
                                                )
                                              ],
                                            )));
                                  },
                                )
                              : const SizedBox()
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

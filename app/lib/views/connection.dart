import 'dart:math';
import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';
import 'package:highfive/constants/helper.dart';
import 'package:highfive/views/normal_content.dart';
import 'package:highfive/widgets/header.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;
  static const hotspotName = Helper.wifiName;
  String wifiNamee = "";

  Future<String> getWifiName() async {
    final NetworkInfo info = NetworkInfo();
    var wifiName = await info.getWifiName();
    setState(() {
      wifiNamee = wifiName ?? "ERROR";
    });
    return wifiName ?? "ERROR";
  }

  @override
  void initState() {
    getWifiName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<ConnectivityResult>(
        stream: connectivityStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == ConnectivityResult.wifi) {
            // Check SSID
            var ssid = wifiNamee.substring(1, wifiNamee.length - 1);
            if (ssid != hotspotName) {
              // print(wifiNamee.substring(1, wifiNamee.length - 1) +
              //     "  " +
              //     hotspotName.toString());
              // final wifiName = "lol";
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Header(title: Helper.home),
                  Container(
                    width: min(MediaQuery.of(context).size.width - 40,
                        MediaQuery.of(context).size.height - 100),
                    height: min(MediaQuery.of(context).size.width - 40,
                        MediaQuery.of(context).size.height - 100),
                    decoration: BoxDecoration(
                        color: AppColors.lightblue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Helper.wifiPath,
                          width: MediaQuery.of(context).size.width / 4,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Please connect to $hotspotName\n(Raspberry Pi) WiFi Network",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text("Current WiFi SSID is $wifiNamee"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                    width: double.maxFinite,
                  ),
                ],
              );
            } else {
              // Display normal app content
              return const NormalContent();
            }
          } else {
            // Display loading indicator or other appropriate UI
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.maxFinite,
                ),
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Please connect to the WiFi Network\nbefore proceeding",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: double.maxFinite,
                ),
              ],
            );
          }
        },
      )),
    );
  }
}

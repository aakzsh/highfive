import 'package:flutter/material.dart';
import 'package:highfive/constants/colors.dart';
import 'package:highfive/constants/helper.dart';
import 'package:highfive/views/selection.dart';
import 'package:highfive/views/usage.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomeScreen extends StatelessWidget {
  Future<void> requestLocationPermission(context) async {
    final PermissionStatus statusLocation = await Permission.location.request();
    if (statusLocation.isDenied) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text(
                  "Need Location Permission!",
                  style: TextStyle(color: Colors.redAccent),
                ),
                content: const Text(
                    "Fine location permission is required for Android 8+ devices for the app to work in a desired manner. Please allow the location permissions!"),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  )
                ],
              )));
    } else if (statusLocation.isPermanentlyDenied) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text(
                  "Need Location Permission!",
                  style: TextStyle(color: Colors.redAccent),
                ),
                content: const Text(
                    "Fine location permission is required for Android 8+ devices for the app to work in a desired manner. Please allow the location permissions!"),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  )
                ],
              )));
      // Handle permanently denied scenario
    } else if (statusLocation.isGranted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Selection()));
      // Accessing location is allowed
    }
  }

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
            width: double.maxFinite,
          ),
          Column(
            children: [
              Image.asset(
                Helper.headingpath,
                width: 240,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                Helper.subtitle,
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  await requestLocationPermission(context);
                },
                minWidth: 240,
                height: 45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: AppColors.blue,
                child: const Text(
                  Helper.start,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Text(Helper.or),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Usage()));
                },
                child: const Text(
                  Helper.learnToUse,
                  style: TextStyle(color: AppColors.blue),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

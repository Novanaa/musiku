import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/utils/permission.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    // Present modal bottom sheet on application init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: ColorConstants.modalBackgroundColor,
        builder: (context) => welcomeDrawer(),
      );
    });
  }

  Container welcomeDrawer() {
    return Container(
      height: 260,
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 25),
      child: Column(
        children: [
          const Text("Before using this app",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 5,
          ),
          const Opacity(
            opacity: 0.8,
            child: Text(
                "By using Musiku, you agree to its terms and conditions, including grating access to your device music library.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.5)),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    enableFeedback: true,
                  ),
                  onPressed: () {
                    getPermission();
                  },
                  child: const Text("Accept",
                      style: TextStyle(
                          color: ColorConstants.backgroundColor,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: const ButtonStyle(enableFeedback: true),
                  onPressed: () {
                    exit(0);
                  },
                  child: const Text("Quit this app",
                      style: TextStyle(
                          color: ColorConstants.destructiveColor,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
      ),
    );
  }
}

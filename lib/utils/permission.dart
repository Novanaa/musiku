import 'dart:io';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:musiku/screens/layout.dart';
import 'package:musiku/screens/welcome.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> checkPermission() async {
  bool isGranted = await Permission.storage.isGranted;

  if (!isGranted) Get.to(const WelcomeScreen());
}

Future<void> getPermission() async {
  bool isGranted = await Permission.storage.isGranted;

  if (!isGranted) {
    PermissionStatus permissionStatus = await Permission.storage.request();

    if (permissionStatus.isGranted) {
      Get.offAll(const Layout(), transition: Transition.cupertino);
    }

    if (permissionStatus.isDenied) exit(0);

    if (permissionStatus.isPermanentlyDenied) await openAppSettings();
  }
}
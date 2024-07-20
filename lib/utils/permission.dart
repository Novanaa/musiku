import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:musiku/screens/layout.dart';
import 'package:musiku/screens/welcome.dart';
import 'package:musiku/utils/events.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<bool> checkPermission() async {
  final OnAudioQuery audioQuery = OnAudioQuery();
  bool isGranted = await audioQuery.permissionsStatus();

  if (!isGranted) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Get.offAll(() => const WelcomeScreen());
    });
  }

  return isGranted;
}

Future<void> getPermission() async {
  final OnAudioQuery audioQuery = OnAudioQuery();
  bool isGranted = await audioQuery.permissionsStatus();

  if (!isGranted) {
    bool isPermissionGranted = await audioQuery.checkAndRequest();

    if (isPermissionGranted) {
      await onApplicationInit();
      Get.offAll(const Layout(), transition: Transition.cupertino);
    }

    if (!isPermissionGranted) exit(0);
  }
}

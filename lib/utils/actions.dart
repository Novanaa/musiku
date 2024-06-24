import 'dart:io';

import 'package:get/get.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/utils/common.dart';

void deleteMusic(String path) {
  try {
    final MusicController musicController = Get.put(MusicController());
    File(path).deleteSync();
    musicController.refetchMusic();
  } catch (err) {
    showToast("Something wrong happed.");
  }
}

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/services/music_player.dart';
import 'package:musiku/utils/permission.dart';

Future<void> applicationInit() async {
  final MusicController musicController = Get.put(MusicController());
  final DirectoryController directoryController =
      Get.put(DirectoryController());

  bool isPermissionGranted = await checkPermission();

  await MusicPlayer.setRepeatMode(LoopMode.all);

  if (isPermissionGranted) {
    musicController.getMusic();
    directoryController.getDirectory();
  }
}

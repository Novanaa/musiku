import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/utils/permission.dart';

Future<void> applicationInit() async {
  final MusicController musicController = Get.put(MusicController());
  final DirectoryController directoryController =
      Get.put(DirectoryController());

  bool isPermissionGranted = await checkPermission();

  if (isPermissionGranted) {
    musicController.getMusic();
    directoryController.getDirectory();

    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
  }
}

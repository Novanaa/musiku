import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/model.dart';
import 'package:musiku/repository/current_played.dart';
import 'package:musiku/services/music_player.dart';
import 'package:musiku/utils/permission.dart';

Future<void> applicationInit() async {
  final MusicController musicController = Get.put(MusicController());
  final DirectoryController directoryController =
      Get.put(DirectoryController());

  bool isPermissionGranted = await checkPermission();
  CurrentMusicPlayedModel? currentMusicPlayed =
      await CurrentMusicPlayed.retrieve();

  await MusicPlayer.setRepeatMode(LoopMode.all);

  if (currentMusicPlayed != null) {
    MusicPlayer.load(currentMusicPlayed.music.data);
  }

  if (isPermissionGranted) {
    musicController.getMusic();
    directoryController.getDirectory();
  }
}

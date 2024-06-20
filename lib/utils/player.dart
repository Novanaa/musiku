import 'package:get/get.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/model.dart';
import 'package:musiku/services/music_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<void> playMusic(SongModel music) async {
  final CurrentMusicPlayedController currentMusicPlayedController =
      Get.put(CurrentMusicPlayedController());

  currentMusicPlayedController.setCurrentMusicPlayed(
      CurrentMusicPlayedModel(music: music, position: 0));
  await MusicPlayer.load(music.data);
  await MusicPlayer.play();
}

Future<void> replayMusic() async {
  final CurrentMusicPlayedController currentMusicPlayedController =
      Get.put(CurrentMusicPlayedController());
  int currentMusicPlayedPosition =
      currentMusicPlayedController.currentMusicPlayed.value?.position ?? 0;

  await MusicPlayer.load(currentMusicPlayedController
      .currentMusicPlayed.value?.music.data as String);
  await MusicPlayer.seekTo(Duration(milliseconds: currentMusicPlayedPosition));
  await MusicPlayer.play();
}

Future<void> pauseMusic() async {
  final CurrentMusicPlayedController currentMusicPlayedController =
      Get.put(CurrentMusicPlayedController());
  Duration position = MusicPlayer.getInstance().position;

  currentMusicPlayedController.setCurrentMusicPlayed(CurrentMusicPlayedModel(
      music: currentMusicPlayedController.currentMusicPlayed.value?.music
          as SongModel,
      position: position.inMilliseconds));
  await MusicPlayer.pause();
}

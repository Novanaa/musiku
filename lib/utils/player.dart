import 'package:get/get.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/model.dart';
import 'package:musiku/services/music_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<void> playMusic(SongModel music) async {
  final CurrentMusicPlayedController currentMusicPLayedController =
      Get.put(CurrentMusicPlayedController());

  await MusicPlayer.load(music.data);
  await MusicPlayer.play();
  currentMusicPLayedController.setCurrentMusicPlayed(
      CurrentMusicPlayedModel(music: music, position: 0));
}

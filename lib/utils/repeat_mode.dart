import 'dart:math';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/services/music_player.dart';
import 'package:musiku/utils/player.dart';

void repeatMusic() {
  MusicPlayer.getInstance().setLoopMode(LoopMode.all);
}

void shuffleMusic() {
  final MusicController musicController = Get.put(MusicController());
  MusicPlayer.getInstance().playerStateStream.listen((value) {
    if (value.processingState == ProcessingState.completed) {
      int randomInt = Random().nextInt(musicController.music.length);
      playMusic(musicController.music[randomInt]);
    }
  });
}

void playSequentially() {
  MusicPlayer.getInstance().playerStateStream.listen((value) {
    if (value.processingState == ProcessingState.completed) playNextMusic();
  });
}

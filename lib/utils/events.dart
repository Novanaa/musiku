import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/model.dart';
import 'package:musiku/services/music_player.dart';
import 'package:musiku/utils/permission.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<void> onApplicationInit() async {
  final MusicController musicController = Get.put(MusicController());
  final DirectoryController directoryController =
      Get.put(DirectoryController());
  final ArtistController artistController = Get.put(ArtistController());

  bool isPermissionGranted = await checkPermission();

  if (isPermissionGranted) {
    musicController.getMusic();
    directoryController.getDirectory();
    artistController.getArtist();

    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
  }
}

void onApplicationTerminated() {
  final CurrentMusicPlayedController currentMusicPlayedController =
      Get.put(CurrentMusicPlayedController());

  WidgetsBinding.instance.addPostFrameCallback((_) {
    WidgetsBinding.instance.addObserver(ApplicationEvents(onDetached: () {
      if (currentMusicPlayedController.currentMusicPlayed.value != null) {
        currentMusicPlayedController.setCurrentMusicPlayed(
            CurrentMusicPlayedModel(
                music: currentMusicPlayedController
                    .currentMusicPlayed.value?.music as SongModel,
                position: MusicPlayer.getInstance().position.inMilliseconds));
      }
    }));
  });
}

class ApplicationEvents extends WidgetsBindingObserver {
  VoidCallback? onDetached;
  ApplicationEvents({this.onDetached});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.detached) onDetached!();
  }
}

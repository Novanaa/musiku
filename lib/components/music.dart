import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musiku/components/music_options.dart';
import 'package:musiku/components/music_player.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/services/music_player.dart';
import 'package:musiku/utils/common.dart';
import 'package:musiku/utils/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Music extends StatelessWidget {
  final SongModel song;
  Music({super.key, required this.song});

  final CurrentMusicPlayedController currentMusicPlayedController =
      Get.put(CurrentMusicPlayedController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        playMusic(song);
        openMusicPlayer(context);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 2),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [musicTitle(), musicDescription()],
            ),
          ),
          GestureDetector(
            child: SvgPicture.asset("assets/icons/music-options.svg"),
            onTap: () => openMusicOptionsModalBottomSheet(context, song),
          )
        ]),
      ),
    );
  }

  Opacity musicDescription() {
    return Opacity(
        opacity: 0.8,
        child: Text(
          getMusicMetadata(song) ?? "Unknown albums - Unkown artist",
          style: const TextStyle(fontSize: 11.5),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ));
  }

  StreamBuilder musicTitle() {
    return StreamBuilder<PlayerState>(
        stream: MusicPlayer.getInstance().playerStateStream,
        builder: (context, snapshot) {
          bool isPlaying = (currentMusicPlayedController
                      .currentMusicPlayed.value?.music.data ==
                  song.data) &&
              (snapshot.data?.playing ?? false);

          return Row(
            children: [
              Expanded(
                child: Text(song.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15)),
              ),
              const SizedBox(width: 5),
              isPlaying
                  ? Image.asset(
                      "assets/images/sound-wave.gif",
                      width: 35,
                      height: 35,
                    )
                  : const SizedBox(width: 35, height: 35)
            ],
          );
        });
  }
}

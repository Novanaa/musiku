import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musiku/components/music_options.dart';
import 'package:musiku/components/music_player.dart';
import 'package:musiku/utils/common.dart';
import 'package:musiku/utils/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Music extends StatelessWidget {
  final SongModel song;
  const Music({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        playMusic(song);
        openMusicPlayer(context);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(song.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15)),
                const SizedBox(
                  height: 5,
                ),
                Opacity(
                    opacity: 0.8,
                    child: Text(
                      getMusicMetadata(song) ??
                          "Unknown albums - Unkown artist",
                      style: const TextStyle(fontSize: 11.5),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ))
              ],
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
}

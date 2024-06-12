import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Music extends StatelessWidget {
  final SongModel song;
  const Music({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO: Implement play music feature
      onTap: () {},
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
                const Opacity(
                    opacity: 0.8,
                    child: Text(
                      "Unknown albums - Unkown artis",
                      style: TextStyle(fontSize: 11.5),
                    ))
              ],
            ),
          ),
          GestureDetector(
            child: SvgPicture.asset("assets/icons/music-options.svg"),
            // TODO: Implement music options feature
            onTap: () {},
          )
        ]),
      ),
    );
  }
}
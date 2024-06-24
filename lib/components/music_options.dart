import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/utils/actions.dart';
import 'package:musiku/utils/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

void openMusicOptionsModalBottomSheet(BuildContext context, SongModel song) {
  showModalBottomSheet(
      context: context,
      builder: (context) => MusicOptions(music: song),
      backgroundColor: ColorConstants.modalBackgroundColor,
      isScrollControlled: true);
}

class MusicOptions extends StatelessWidget {
  const MusicOptions({super.key, required this.music});
  final SongModel music;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Get.back();
              playMusic(music);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/play.svg",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Play Music",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            // TODO: Implement add to playlist feature
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/solid-media-library.svg",
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Save To Playlist",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            // TODO: Implement add to favorites music feature
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/heart.svg"),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Save To Favorites",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            // TODO: Implement show music information
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/info.svg"),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Music Information",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Get.back();
              deleteMusic(music.data);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/trash.svg",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Delete Music",
                      style: TextStyle(
                        color: ColorConstants.destructiveColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

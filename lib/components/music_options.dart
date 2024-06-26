import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/utils/actions.dart';
import 'package:musiku/utils/common.dart';
import 'package:musiku/utils/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:musiku/components/music_player.dart';

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
              openMusicPlayer(context);
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
            onTap: () {
              Get.back();
              openMusicInformationDrawer(context, music);
            },
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

void openMusicInformationDrawer(BuildContext context, SongModel music) {
  showModalBottomSheet(
      context: context,
      builder: (context) => MusicInformationDrawer(
            music: music,
          ),
      backgroundColor: ColorConstants.modalBackgroundColor,
      isScrollControlled: true);
}

class MusicInformationDrawer extends StatelessWidget {
  final SongModel music;
  const MusicInformationDrawer({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [musicInformationHeader(), musicInformationContent()],
      ),
    );
  }

  Container musicInformationHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: const Center(
        child: Text("Music Information",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
      ),
    );
  }

  Container musicInformationContent() {
    String modificationTime = getDate(music.dateModified as int);
    String timeAdded = getDate(music.dateAdded as int);

    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorConstants.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/file.svg",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text("Filename",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          music.displayName,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorConstants.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/headphones.svg",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text("Duration",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          parseDuration(music.duration as int),
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorConstants.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/file-digit.svg",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text("Filesize",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          parseFileSize(music.size),
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorConstants.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/file-edit.svg",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text("Modified Time",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          modificationTime,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorConstants.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/file-plus.svg",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text("Time Added",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          timeAdded,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorConstants.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/file-audio.svg",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text("Extension",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          music.fileExtension.toUpperCase(),
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorConstants.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/folder.svg",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text("File Location",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          music.data,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

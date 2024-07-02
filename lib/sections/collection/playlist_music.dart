import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musiku/components/music_options.dart';
import 'package:musiku/components/music_player.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/services/music_player.dart';
import 'package:musiku/utils/actions.dart';
import 'package:musiku/utils/common.dart';
import 'package:musiku/utils/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:musiku/model.dart' as model;

class PlaylistMusic extends StatelessWidget {
  final SongModel song;
  final model.PlaylistModel playlist;
  PlaylistMusic({super.key, required this.song, required this.playlist});

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
            onTap: () => openPlaylistMusicOptionsModalBottomSheet(
                context, song, playlist),
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
                  : const SizedBox(width: 15, height: 35)
            ],
          );
        });
  }
}

void openPlaylistMusicOptionsModalBottomSheet(
    BuildContext context, SongModel song, model.PlaylistModel playlist) {
  showModalBottomSheet(
      context: context,
      builder: (context) => PlaylistMusicOptions(
            music: song,
            playlist: playlist,
          ),
      backgroundColor: ColorConstants.modalBackgroundColor,
      isScrollControlled: true);
}

class PlaylistMusicOptions extends StatelessWidget {
  const PlaylistMusicOptions(
      {super.key, required this.music, required this.playlist});
  final SongModel music;
  final model.PlaylistModel playlist;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
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
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
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
            // TODO: Implement remove music from playlist feature
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/playlist.svg",
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Remove From Playlist",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          Obx(() => musicOptionsFavoritesMusic()),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Get.back();
              openMusicInformationDrawer(context, music);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
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
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
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

  InkWell musicOptionsFavoritesMusic() {
    bool isFavorited = isMusicFavorited(music);

    return isFavorited
        ? InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              unfavoriteMusic(music);
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/heart.svg"),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Remove From Favorites",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          )
        : InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              addFavoritesMusic(music);
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/outline-heart.svg"),
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
          );
  }
}

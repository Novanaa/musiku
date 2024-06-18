import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/services/music_player.dart';
import 'package:musiku/utils/common.dart';
import 'package:musiku/utils/player.dart';

class FloatingMusic extends StatefulWidget {
  const FloatingMusic({super.key});

  @override
  State<FloatingMusic> createState() => _FloatingMusicState();
}

class _FloatingMusicState extends State<FloatingMusic> {
  bool isPlaying = false;
  final CurrentMusicPlayedController currentMusicPlayedController =
      Get.put(CurrentMusicPlayedController());

  bool isMusicControllerDisable() {
    return currentMusicPlayedController.currentMusicPlayed.value == null;
  }

  @override
  void dispose() {
    super.dispose();
    MusicPlayer.getInstance().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        // TODO: Implement open music controller drawer/bottom sheet modal
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 55, 55, 55),
                    ColorConstants.modalBackgroundColor,
                  ]),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              floatingMusicMetadata(context),
              floatingMusicController()
            ],
          ),
        ),
      ),
    );
  }

  Opacity floatingMusicController() {
    return Opacity(
      opacity: isMusicControllerDisable() ? 0.8 : 1,
      child: Row(
        children: [
          GestureDetector(
            // TODO: Implement play previous music feature
            onTap: isMusicControllerDisable() ? null : () {},
            child: SvgPicture.asset("assets/icons/prev-music.svg"),
          ),
          const SizedBox(width: 10),
          playAndPauseButton(),
          const SizedBox(width: 10),
          GestureDetector(
            // TODO: Implement play next music feature
            onTap: isMusicControllerDisable() ? null : () {},
            child: SvgPicture.asset("assets/icons/next-music.svg"),
          ),
        ],
      ),
    );
  }

  GestureDetector playAndPauseButton() {
    MusicPlayer.getInstance().playerStateStream.listen((state) {
      if (state.playing != isPlaying) setState(() => isPlaying = state.playing);
    });

    return isPlaying
        ? GestureDetector(
            onTap: isMusicControllerDisable()
                ? null
                : () {
                    pauseMusic();
                  },
            child: SvgPicture.asset("assets/icons/pause.svg"),
          )
        : GestureDetector(
            onTap: isMusicControllerDisable()
                ? null
                : () {
                    replayMusic();
                  },
            child: SvgPicture.asset("assets/icons/play.svg"),
          );
  }

  Row floatingMusicMetadata(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.3,
          child: SvgPicture.asset(
            "assets/icons/music.svg",
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentMusicPlayedController
                          .currentMusicPlayed.value?.music.displayName ??
                      "What do you like to play?",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14.5),
                ),
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    getMusicMetadata(currentMusicPlayedController
                            .currentMusicPlayed.value?.music) ??
                        "No music audio history provided!",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11.5),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

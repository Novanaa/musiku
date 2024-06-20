import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/services/music_player.dart';
import 'package:musiku/utils/common.dart';
import 'package:musiku/utils/player.dart';

class FloatingMusic extends StatelessWidget {
  FloatingMusic({super.key});

  final CurrentMusicPlayedController currentMusicPlayedController =
      Get.put(CurrentMusicPlayedController());

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

  Obx floatingMusicController() {
    return Obx(
      () => Opacity(
        opacity: currentMusicPlayedController.currentMusicPlayed.value == null
            ? 0.8
            : 1,
        child: Row(
          children: [
            GestureDetector(
              onTap:
                  currentMusicPlayedController.currentMusicPlayed.value == null
                      ? null
                      : playPrevMusic,
              child: SvgPicture.asset("assets/icons/prev-music.svg"),
            ),
            const SizedBox(width: 10),
            playAndPauseButton(),
            const SizedBox(width: 10),
            GestureDetector(
              onTap:
                  currentMusicPlayedController.currentMusicPlayed.value == null
                      ? null
                      : playNextMusic,
              child: SvgPicture.asset("assets/icons/next-music.svg"),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder playAndPauseButton() {
    return StreamBuilder<PlayerState>(
      stream: MusicPlayer.getInstance().playerStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return GestureDetector(
            onTap: null,
            child: SvgPicture.asset("assets/icons/play.svg"),
          );
        }

        return snapshot.data?.playing ?? false
            ? GestureDetector(
                onTap: currentMusicPlayedController.currentMusicPlayed.value ==
                        null
                    ? null
                    : pauseMusic,
                child: SvgPicture.asset("assets/icons/pause.svg"),
              )
            : GestureDetector(
                onTap: currentMusicPlayedController.currentMusicPlayed.value ==
                        null
                    ? null
                    : replayMusic,
                child: SvgPicture.asset("assets/icons/play.svg"),
              );
      },
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
        Obx(
          () => SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(
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

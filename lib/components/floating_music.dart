import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/services/music_player.dart';
import 'package:musiku/utils/common.dart';
import 'package:musiku/utils/player.dart';
import 'package:musiku/components/music_player.dart';

class FloatingMusic extends StatelessWidget {
  FloatingMusic({super.key});

  final CurrentMusicPlayedController currentMusicPlayedController =
      Get.put(CurrentMusicPlayedController());
  final RepeatModeController repeatModeController =
      Get.put(RepeatModeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Positioned(
        bottom: -5,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: currentMusicPlayedController.currentMusicPlayed.value == null
              ? null
              : () => openMusicPlayer(context),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 47, 47, 47),
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
      ),
    );
  }

  Opacity floatingMusicController() {
    return Opacity(
      opacity: currentMusicPlayedController.currentMusicPlayed.value == null
          ? 0.8
          : 1,
      child: Row(
        children: [
          GestureDetector(
            onTap: playPrevMusic,
            child: SvgPicture.asset("assets/icons/prev-music.svg"),
          ),
          const SizedBox(width: 10),
          playAndPauseButton(),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: playNextMusic,
            child: SvgPicture.asset("assets/icons/next-music.svg"),
          ),
        ],
      ),
    );
  }

  StreamBuilder playAndPauseButton() {
    return StreamBuilder<PlayerState>(
      stream: MusicPlayer.getInstance().playerStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Opacity(
            opacity: 0.6,
            child: GestureDetector(
              onTap: null,
              child: SvgPicture.asset("assets/icons/play.svg"),
            ),
          );
        }

        bool isPlaying = snapshot.data?.playing ?? false;
        repeatModeController.handleRepeatModeChanges();

        return isPlaying &&
                !(snapshot.data?.processingState == ProcessingState.completed)
            ? GestureDetector(
                onTap: pauseMusic,
                child: SvgPicture.asset("assets/icons/pause.svg"),
              )
            : GestureDetector(
                onTap: replayMusic,
                child: SvgPicture.asset("assets/icons/play.svg"),
              );
      },
    );
  }

  SizedBox floatingMusicMetadata(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.55,
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
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.5),
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
    );
  }
}

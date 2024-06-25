import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/sections/home/bottom_sheet.dart';
import 'package:musiku/services/music_player.dart';
import 'package:musiku/utils/common.dart';
import 'package:musiku/utils/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:musiku/components/music_options.dart';

void openMusicPlayer(BuildContext context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => MusicPlayerDrawer(),
      isScrollControlled: true);
}

class MusicPlayerDrawer extends StatefulWidget {
  MusicPlayerDrawer({super.key});

  @override
  State<MusicPlayerDrawer> createState() => _MusicPlayerDrawerState();
}

class _MusicPlayerDrawerState extends State<MusicPlayerDrawer> {
  final CurrentMusicPlayedController currentMusicPlayedController =
      Get.put(CurrentMusicPlayedController());

  final double iconWidth = 28;

  final double iconHeight = 28;

  final double controllerIconWidth = 48;

  final double controllerIconHeight = 48;

  late final Image musicPlayerPlaceholder;

  @override
  void initState() {
    super.initState();
    musicPlayerPlaceholder = Image.asset(
      "assets/images/music-player-placeholder.jpg",
      height: 290,
      fit: BoxFit.cover,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(musicPlayerPlaceholder.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.zero,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 62, 62, 62),
              Color.fromARGB(255, 7, 7, 7),
            ]),
      ),
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 55),
      width: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          musicPlayerDrawerHeader(context),
          musicPlayerDrawerImagePlaceholder(),
          musicPlayerDrawerMetadata(context),
          musicPlayerDrawerProgressBar(),
          musicPlayerDrawerController(context)
        ],
      ),
    );
  }

  Container musicPlayerDrawerImagePlaceholder() {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: musicPlayerPlaceholder,
        ));
  }

  Row musicPlayerDrawerHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () => Get.back(),
            child: SvgPicture.asset("assets/icons/arrow-down.svg",
                width: iconWidth, height: iconHeight)),
        const Text("Musiku",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        GestureDetector(
            onTap: () => openMusicOptionsModalBottomSheet(
                context,
                currentMusicPlayedController.currentMusicPlayed.value?.music
                    as SongModel),
            child: SvgPicture.asset("assets/icons/music-options.svg",
                width: iconWidth, height: iconHeight))
      ],
    );
  }

  Container musicPlayerDrawerMetadata(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentMusicPlayedController.currentMusicPlayed.value
                          ?.music.displayName as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Opacity(
                      opacity: 0.8,
                      child: Text(
                        "${getMusicMetadata(currentMusicPlayedController.currentMusicPlayed.value?.music as SongModel)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              )),
          GestureDetector(
            // TODO: Implement favorites music feature
            onTap: null,
            child: SvgPicture.asset("assets/icons/heart.svg",
                width: iconWidth, height: iconHeight),
          )
        ],
      ),
    );
  }

  Container musicPlayerDrawerProgressBar() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: StreamBuilder<Duration>(
        stream: MusicPlayer.getInstance().positionStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ProgressBar(
              progress: Duration(
                  milliseconds: currentMusicPlayedController
                      .currentMusicPlayed.value?.position as int),
              thumbColor: ColorConstants.textColor,
              progressBarColor: ColorConstants.textColor,
              onSeek: null,
              total: Duration(
                  milliseconds: currentMusicPlayedController
                      .currentMusicPlayed.value?.music.duration as int),
            );
          }

          Duration progress = snapshot.data?.inMilliseconds == 0
              ? Duration(
                  milliseconds: currentMusicPlayedController
                      .currentMusicPlayed.value?.position as int)
              : snapshot.data ?? const Duration(milliseconds: 0);

          return ProgressBar(
            progress: progress,
            thumbColor: ColorConstants.textColor,
            progressBarColor: ColorConstants.textColor,
            total: Duration(
                milliseconds: currentMusicPlayedController
                    .currentMusicPlayed.value?.music.duration as int),
            onSeek: (Duration position) => MusicPlayer.seekTo(position),
          );
        },
      ),
    );
  }

  Container musicPlayerDrawerController(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => openRepeatModeBottomSheet(context),
            child: SvgPicture.asset(
              "assets/icons/arrow-path.svg",
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => playPrevMusic(),
                child: SvgPicture.asset(
                  "assets/icons/skip-back.svg",
                  width: controllerIconWidth,
                  height: controllerIconHeight,
                ),
              ),
              const SizedBox(width: 15),
              musicPlayerDrawerPlayAndPauseButton(),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () => playNextMusic(),
                child: SvgPicture.asset(
                  "assets/icons/skip-forward.svg",
                  width: controllerIconWidth,
                  height: controllerIconHeight,
                ),
              ),
            ],
          ),
          GestureDetector(
            // TODO: Implement add to playlist feature
            onTap: null,
            child: SvgPicture.asset(
              "assets/icons/list-options.svg",
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder musicPlayerDrawerPlayAndPauseButton() {
    return StreamBuilder<PlayerState>(
        stream: MusicPlayer.getInstance().playerStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Opacity(
              opacity: 0.6,
              child: GestureDetector(
                onTap: null,
                child: SvgPicture.asset("assets/icons/solid-play.svg",
                    width: controllerIconWidth + 5,
                    height: controllerIconHeight + 5),
              ),
            );
          }

          bool isPlaying = snapshot.data?.playing ?? false;

          return isPlaying &&
                  !(snapshot.data?.processingState == ProcessingState.completed)
              ? GestureDetector(
                  onTap: pauseMusic,
                  child: SvgPicture.asset("assets/icons/solid-pause.svg",
                      width: controllerIconWidth + 5,
                      height: controllerIconHeight + 5),
                )
              : GestureDetector(
                  onTap: replayMusic,
                  child: SvgPicture.asset("assets/icons/solid-play.svg",
                      width: controllerIconWidth + 5,
                      height: controllerIconHeight + 5),
                );
        });
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musiku/constants/color.dart';

class FloatingMusic extends StatelessWidget {
  const FloatingMusic({super.key});

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

  Row floatingMusicController() {
    return Row(
      children: [
        GestureDetector(
          // TODO: Implement play previous music feature
          onTap: () {},
          child: SvgPicture.asset("assets/icons/prev-music.svg"),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          // TODO: Implement play and pause music feature
          onTap: () {},
          // TODO: Validate icon if the music is playing or not
          child: SvgPicture.asset("assets/icons/play.svg"),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          // TODO: Implement play next music feature
          onTap: () {},
          child: SvgPicture.asset("assets/icons/next-music.svg"),
        ),
      ],
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // TODO: Update data to current music played
                // This is a placeholder for right now! change it later on.
                "What do you like to play?",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.5),
              ),
              Opacity(
                opacity: 0.8,
                child: Text(
                  // TODO: Update data to current music played
                  // This is a placeholder for right now! change it later on.
                  "No music audio history provided!",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.5),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:musiku/components/music.dart';
import 'package:musiku/components/placeholder.dart';
import 'package:musiku/controller.dart';

class MusicList extends StatelessWidget {
  MusicList({super.key});

  final MusicController musicController = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    if (musicController.music.isEmpty) return const EmptyMusicPlaceholder();

    return Flexible(
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          itemCount: musicController.music.length,
          itemBuilder: (BuildContext context, int index) =>
              Music(song: musicController.music[index]),
        ),
      ),
    );
  }
}

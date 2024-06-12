import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:musiku/controller.dart';

class MusicList extends StatelessWidget {
  MusicList({super.key});

  final MusicController musicController = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

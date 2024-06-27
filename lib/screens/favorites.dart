import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musiku/components/music.dart';
import 'package:musiku/components/placeholder.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';

class FavoritesMusicScreen extends StatelessWidget {
  const FavoritesMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: favoritesMusicScreenAppBar(),
      body: favoritesMusicList(),
    );
  }

  AppBar favoritesMusicScreenAppBar() {
    return AppBar(
      title: const Text("Favorites Music"),
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: ColorConstants.textColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w700,
          fontSize: 17),
      backgroundColor: ColorConstants.backgroundColor,
      foregroundColor: ColorConstants.textColor,
    );
  }

  Widget favoritesMusicList() {
    final FavoritesMusicController favoritesMusicController =
        Get.put(FavoritesMusicController());

    if (favoritesMusicController.favoritesMusic.isEmpty) {
      return const EmptyMusicPlaceholder();
    }

    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.only(bottom: 10),
        itemBuilder: (BuildContext context, int index) =>
            Music(song: favoritesMusicController.favoritesMusic[index]),
        itemCount: favoritesMusicController.favoritesMusic.length,
      ),
    );
  }
}

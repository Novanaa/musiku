import 'dart:io';

import 'package:get/get.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/utils/common.dart';
import 'package:on_audio_query/on_audio_query.dart';

void deleteMusic(String path) {
  try {
    final MusicController musicController = Get.put(MusicController());
    File(path).deleteSync();
    musicController.refetchMusic();
  } catch (err) {
    showToast("Something wrong happed.");
  }
}

void addFavoritesMusic(SongModel song) {
  final FavoritesMusicController favoritesMusicController =
      Get.put(FavoritesMusicController());
  favoritesMusicController.addFavoritesMusic(song);
}

void unfavoriteMusic(SongModel song) {
  final FavoritesMusicController favoritesMusicController =
      Get.put(FavoritesMusicController());
  favoritesMusicController.unfavoriteMusic(song);
}

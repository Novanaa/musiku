import 'dart:io';

import 'package:get/get.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/screens/collection.dart';
import 'package:musiku/utils/common.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:musiku/model.dart' as model;

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

void addPlaylist(String playlistTitle) {
  final PlaylistController playlistController = Get.put(PlaylistController());

  if (playlistTitle.isEmpty || playlistTitle.trim().isEmpty) {
    Get.back();
    showToast("Playlist title should be filled.");
    return;
  }

  Get.to(AddPlaylistSongsScreen(), transition: Transition.cupertino);
  showToast("Sucessfully added playlist.");
  playlistController.setPlaylistState(model.PlaylistModel(
      id: generatePlaylistId(),
      title: playlistTitle,
      totalSongs: 0,
      songs: []));
}

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

  model.PlaylistModel newPlaylist = model.PlaylistModel(
      id: generatePlaylistId(), title: playlistTitle, totalSongs: 0, songs: []);
  Get.to(AddPlaylistSongsScreen(),
      transition: Transition.cupertino, arguments: {'playlist': newPlaylist});
  showToast("Successfully added playlist.");
  playlistController.setPlaylistState(newPlaylist);
}

void addPlaylistSong(String playlistId, SongModel song) {
  final PlaylistController playlistController = Get.put(PlaylistController());
  int playlistIndex =
      playlistController.playlist.indexWhere((value) => value.id == playlistId);
  model.PlaylistModel playlist = playlistController.playlist[playlistIndex];

  if (isMusicAddedToPlaylist(playlist, song)) {
    showToast("Music already added.");
    Get.back();
    return;
  }

  showToast("Successfully saved to playlist");
  Get.back();
  playlistController.addPlaylistSongs(playlistId, song);
}

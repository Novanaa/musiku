import 'dart:math';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:musiku/model.dart' as model;

String? getMusicMetadata(SongModel? song) {
  if (song == null) return null;

  String? albums = song.album == "<unknown>" ? "Unknown albums" : song.album;
  String? artist = song.artist == "<unknown>" ? "Unkown artist" : song.artist;

  return "$albums - $artist";
}

UriAudioSource getAudioSource(SongModel music) {
  return AudioSource.file(music.data,
      tag: MediaItem(
          id: music.data,
          title: music.displayNameWOExt,
          album: music.album == "<unknown>" ? "Unknown album" : music.album,
          artist: music.artist == "<unknown>" ? "Unknown artist" : music.artist,
          duration: Duration(milliseconds: music.duration as int)));
}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorConstants.modalBackgroundColor,
      textColor: ColorConstants.textColor,
      fontSize: 16.0);
}

String getDate(int unixEpoch) {
  return DateFormat("EEEE, d MMMM yyyy")
      .format(DateTime.fromMillisecondsSinceEpoch((unixEpoch * 1000)));
}

String parseFileSize(int bytes) {
  return "${(bytes / (1024 * 1024)).round()} MB";
}

String parseDuration(int duration) {
  Duration convertedDuration = Duration(milliseconds: duration);
  String durationInMinutes = convertedDuration.inMinutes < 10
      ? "0${convertedDuration.inMinutes}"
      : convertedDuration.inMinutes.toString();
  int durationInSeconds = duration % 60.ceil();

  return "$durationInMinutes:${durationInSeconds < 10 ? "0$durationInSeconds" : durationInSeconds}";
}

void openUrl(String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) await launchUrl(uri);
}

bool isMusicFavorited(SongModel music) {
  final FavoritesMusicController favoritesMusicController =
      Get.put(FavoritesMusicController());
  return favoritesMusicController.favoritesMusic
      .where((value) => value.data == music.data)
      .toList()
      .isNotEmpty;
}

String getRandomString(int length) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}

String generatePlaylistId() => getRandomString(5);

bool isMusicAddedToPlaylist(model.PlaylistModel playlist, SongModel music) =>
    playlist.songs
        .where((value) => value.data == music.data)
        .toList()
        .isNotEmpty;

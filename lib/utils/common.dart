import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musiku/constants/color.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

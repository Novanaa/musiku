import 'package:on_audio_query/on_audio_query.dart';

String? getMusicMetadata(SongModel? song) {
  if (song == null) return null;

  String? albums = song.album == "<unknown>" ? "Unknown albums" : song.album;
  String? artist = song.artist == "<unknown>" ? "Unkown artist" : song.artist;

  return "$albums - $artist";
}

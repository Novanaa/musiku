import 'dart:convert';

import 'package:musiku/model.dart';
import 'package:on_audio_query/on_audio_query.dart' as query_model;
import 'package:shared_preferences/shared_preferences.dart';

class PlaylistRepository {
  static const String playlistKey = "playlist";

  static Future<List<PlaylistModel>> getPlaylistState() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    List<dynamic> jsonMap =
        jsonDecode(prefrences.getString(playlistKey) as String);

    return List<PlaylistModel>.from(jsonMap.map(
      (value) => PlaylistModel.fromJson(value),
    )).toList();
  }

  static void setPlaylistState(PlaylistModel state) async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    List<PlaylistModel> playlist = await getPlaylistState();
    playlist.add(state);
    prefrences.setString(playlistKey,
        jsonEncode(playlist.map((value) => value.toJson()).toList()));
  }

  static void init() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    if (prefrences.getString(playlistKey) == null) {
      prefrences.setString(playlistKey, jsonEncode(<PlaylistModel>[]));
    }
  }

  static void deletePlaylistState(String playlistId) async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    List<PlaylistModel> playlist = await getPlaylistState();
    playlist.removeWhere((value) => value.id == playlistId);
    prefrences.setString(playlistKey,
        jsonEncode(playlist.map((value) => value.toJson()).toList()));
  }

  static void addPlaylistSongs(
      String playlistId, query_model.SongModel song) async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    List<PlaylistModel> playlists = await getPlaylistState();
    int playlistIndex = playlists.indexWhere((value) => value.id == playlistId);

    PlaylistModel playlist = playlists[playlistIndex];
    playlist.songs.add(song);
    playlist.totalSongs += 1;
    playlists[playlistIndex] = playlist;

    prefrences.setString(playlistKey,
        jsonEncode(playlists.map((value) => value.toJson()).toList()));
  }

  static void editPlaylistName(
      String playlistId, String newPlaylistName) async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    List<PlaylistModel> playlists = await getPlaylistState();
    int playlistIndex = playlists.indexWhere((value) => value.id == playlistId);

    PlaylistModel playlist = playlists[playlistIndex];
    playlist.title = newPlaylistName;
    playlists[playlistIndex] = playlist;

    prefrences.setString(playlistKey,
        jsonEncode(playlists.map((value) => value.toJson()).toList()));
  }
}

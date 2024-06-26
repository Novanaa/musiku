import 'dart:convert';

import 'package:musiku/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaylistRepository {
  static const String playlistKey = "playlist";

  static Future<List<PlaylistModel>> getPlaylistState() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    List<dynamic> jsonMap =
        jsonDecode(prefrences.getString(playlistKey) as String);

    return List<PlaylistModel>.from(jsonMap.map(
      (value) => PlaylistModel.fromJson(value),
    ));
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
}

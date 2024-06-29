import 'dart:convert';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesMusicRepository {
  static const String favoritesMusicKey = "favorites_music";

  static Future<List<SongModel>> getFavoritesMusicState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<dynamic> jsonMap =
        jsonDecode(preferences.getString(favoritesMusicKey) as String);

    return List<SongModel>.from(
        jsonMap.map((value) => SongModel(value)).toList());
  }

  static void addFavoritesMusic(SongModel song) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<SongModel> favoritesMusicState = await getFavoritesMusicState();

    favoritesMusicState.add(song);
    preferences.setString(favoritesMusicKey,
        jsonEncode(favoritesMusicState.map((value) => value.getMap).toList()));
  }

  static void unfavoriteMusic(SongModel song) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<SongModel> favoritesMusicState = await getFavoritesMusicState();

    favoritesMusicState.removeWhere((value) => value.data == song.data);
    preferences.setString(favoritesMusicKey,
        jsonEncode(favoritesMusicState.map((value) => value.getMap).toList()));
  }

  static void init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString(favoritesMusicKey) == null) {
      preferences.setString(favoritesMusicKey, jsonEncode(<SongModel>[]));
    }
  }
}

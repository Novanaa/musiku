import 'dart:convert';

import 'package:musiku/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentMusicPlayed {
  static const String key = "current_music_played";

  static Future<CurrentMusicPlayedModel?> retrieve() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(key);

    if (data == null) return null;

    Map<String, dynamic> jsonMap = jsonDecode(data);
    return CurrentMusicPlayedModel.fromJson(jsonMap);
  }

  static Future<void> save(CurrentMusicPlayedModel data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, json.encode(data.toJson()));
  }
}

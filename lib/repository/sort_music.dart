import 'package:shared_preferences/shared_preferences.dart';

class SortMusicRepository {
  static const String sortMusicKey = "sort_method";

  static Future<int?> getSortMusicState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(sortMusicKey);
  }

  static void setSortMusicState(int state) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(sortMusicKey, state);
  }
}

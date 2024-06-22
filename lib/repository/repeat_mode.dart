import 'package:shared_preferences/shared_preferences.dart';

class RepeatModeRepository {
  static const String repeatModeKey = "repeat_mode";

  static Future<int?> getRepeatModeState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(repeatModeKey);
  }

  static void setRepeatModeState(int state) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(repeatModeKey, state);
  }
}

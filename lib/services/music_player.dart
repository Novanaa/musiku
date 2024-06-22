import 'package:just_audio/just_audio.dart';
import 'package:musiku/utils/common.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayer {
  static final AudioPlayer _player = AudioPlayer();

  static AudioPlayer getInstance() {
    return _player;
  }

  static Future<void> load(SongModel music) async {
    await _player.setAudioSource(getAudioSource(music));
  }

  static Future<void> play() async {
    await _player.play();
  }

  static Future<void> pause() async {
    await _player.pause();
  }

  static Future<void> seekTo(Duration position) async {
    await _player.seek(position);
  }

  static Future<void> setRepeatMode(LoopMode mode) async {
    await _player.setLoopMode(mode);
  }
}

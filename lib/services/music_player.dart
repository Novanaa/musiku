import 'package:just_audio/just_audio.dart';

class MusicPlayer {
  static final AudioPlayer _player = AudioPlayer();

  static AudioPlayer getInstance() {
    return _player;
  }

  static Future<void> load(String uri) async {
    AudioSource audioSource = AudioSource.file(uri);
    await _player.setAudioSource(audioSource);
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

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayer {
  static final AudioPlayer _player = AudioPlayer();

  static AudioPlayer getInstance() {
    return _player;
  }

  static Future<void> load(SongModel music) async {
    await _player.setAudioSource(AudioSource.file(music.data,
        tag: MediaItem(
            id: music.data,
            title: music.displayNameWOExt,
            album: music.album == "<unknown>" ? "Unknown album" : music.album,
            artist:
                music.artist == "<unknown>" ? "Unknown artist" : music.artist,
            duration: Duration(milliseconds: music.duration as int))));
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

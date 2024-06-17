import 'package:musiku/model.dart';
import 'package:musiku/repository/current_played.dart';
import 'package:musiku/services/music_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<void> playMusic(SongModel music) async {
  await MusicPlayer.load(music.data);
  await MusicPlayer.play();
  CurrentMusicPlayed.save(CurrentMusicPlayedModel(music: music, position: 0));
}

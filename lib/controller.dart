import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final RxList<SongModel> music = <SongModel>[].obs;

  void getMusic() async {
    List<SongModel> songs = await _audioQuery.querySongs();
    music.addAll(songs);
    update();
  }
}

import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:musiku/model.dart';

class MusicController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final RxList<SongModel> music = <SongModel>[].obs;

  Future<List<SongModel>> getMusic() async {
    List<SongModel> songs = await _audioQuery.querySongs();
    music.addAll(songs);
    update();

    return songs;
  }
}

class DirectoryController extends GetxController {
  final RxList<Directory> directory = <Directory>[].obs;
  final MusicController _musicController = Get.find<MusicController>();

  void getDirectory() async {
    List<SongModel> music = await _musicController.getMusic();

    List<Directory> mappedDirectories = music
        .map((value) {
          List<String> splitedPath = value.data.split("/");
          splitedPath.removeLast();

          return Directory(path: splitedPath.join("/"), name: splitedPath.last);
        })
        .toSet()
        .toList();

    directory.assignAll(mappedDirectories);
    update();
  }
}

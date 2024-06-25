import 'package:get/get.dart';
import 'package:musiku/repository/current_played.dart';
import 'package:musiku/repository/repeat_mode.dart';
import 'package:musiku/repository/sort_music.dart';
import 'package:musiku/utils/permission.dart';
import 'package:musiku/utils/repeat_mode.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:musiku/model.dart';

class MusicController extends GetxController {
  final SortMusicController sortMusicController =
      Get.find<SortMusicController>();

  final OnAudioQuery _audioQuery = OnAudioQuery();

  final RxList<SongModel> music = <SongModel>[].obs;

  RxInt totalItems = 0.obs;

  @override
  void onInit() {
    ever(sortMusicController.sortMusicState, (_) => refetchMusic());
    super.onInit();
  }

  void refetchMusic() async {
    bool permission = await checkPermission();
    if (permission) getMusic();
  }

  Future<List<SongModel>> getMusic() async {
    Map<int, List<SongModel>> literalSongs = {
      1: await _audioQuery.querySongs(sortType: SongSortType.DATE_ADDED),
      2: (await _audioQuery.querySongs(sortType: SongSortType.DATE_ADDED))
          .reversed
          .toList(),
      3: await _audioQuery.querySongs(sortType: SongSortType.DURATION),
      4: await _audioQuery.querySongs(sortType: SongSortType.SIZE),
      5: await _audioQuery.querySongs(orderType: OrderType.ASC_OR_SMALLER),
      6: await _audioQuery.querySongs(orderType: OrderType.DESC_OR_GREATER)
    };

    List<SongModel> songs =
        literalSongs[sortMusicController.sortMusicState.value] ??
            await _audioQuery.querySongs(sortType: SongSortType.TITLE);

    music.assignAll(songs);
    totalItems = songs.length.obs;
    update();

    return songs;
  }
}

class DirectoryController extends GetxController {
  final RxList<Directory> directory = <Directory>[].obs;

  final OnAudioQuery _audioQuery = OnAudioQuery();

  RxInt totalItems = 0.obs;

  void getDirectory() async {
    List<SongModel> music = await _audioQuery.querySongs();
    List<Directory> mappedDirectories = music
        .map((value) {
          List<String> splitedPath = value.data.split("/");
          splitedPath.removeLast();

          return Directory(path: splitedPath.join("/"), name: splitedPath.last);
        })
        .toSet()
        .toList();

    totalItems = mappedDirectories.length.obs;
    directory.assignAll(mappedDirectories);
    update();
  }
}

class CurrentMusicPlayedController extends GetxController {
  Rx<CurrentMusicPlayedModel?> currentMusicPlayed =
      Rx<CurrentMusicPlayedModel?>(null);

  @override
  void onInit() {
    super.onInit();
    refetchCurrentMusicPlayedState();
  }

  void setCurrentMusicPlayed(CurrentMusicPlayedModel data) async {
    await CurrentMusicPlayedRepository.save(data);
    currentMusicPlayed.value = data;
    update();
  }

  void refetchCurrentMusicPlayedState() async {
    currentMusicPlayed.value = await CurrentMusicPlayedRepository.retrieve();
    update();
  }
}

class SortMusicController extends GetxController {
  RxInt sortMusicState = 1.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    if (await SortMusicRepository.getSortMusicState() == null) {
      // Set sort music state to default state (recently)
      setSortMusicState(1);
    }

    setSortMusicState(await SortMusicRepository.getSortMusicState() as int);
  }

  void setSortMusicState(int state) {
    SortMusicRepository.setSortMusicState(state);
    sortMusicState.value = state;
    update();
  }
}

class RepeatModeController extends GetxController {
  RxInt repeatModeState = 1.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
    ever(repeatModeState, (_) => handleRepeatModeChanges());
  }

  void _init() async {
    if (await RepeatModeRepository.getRepeatModeState() == null) {
      // Set repeat mode to default (shuffle music)
      RepeatModeRepository.setRepeatModeState(1);
    }

    setRepeatModeState(await RepeatModeRepository.getRepeatModeState() as int);
  }

  void setRepeatModeState(int state) {
    RepeatModeRepository.setRepeatModeState(state);
    repeatModeState.value = state;
    update();
  }

  void handleRepeatModeChanges() {
    Map<int, Function> mapModeSetter = {
      1: () => shuffleMusic(),
      2: () => playSequentially(),
      3: () => repeatMusic(),
    };

    Function modeSetter = mapModeSetter[repeatModeState.value] ?? shuffleMusic;
    modeSetter();
  }
}

class ArtistController extends GetxController {
  RxList<ArtistModel> artist = <ArtistModel>[].obs;

  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<void> getArtist() async {
    List<ArtistModel> artistList = await _audioQuery.queryArtists();
    artist.assignAll(artistList);
    update();
  }
}

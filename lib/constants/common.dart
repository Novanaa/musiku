import 'package:musiku/model.dart';

class CommonConstants {
  static final List<SortMusicModel> sortMethodList = [
    SortMusicModel(id: 1, title: "Recently Music Added"),
    SortMusicModel(id: 2, title: "Lately Music Added"),
    SortMusicModel(id: 3, title: "Music Duration"),
    SortMusicModel(id: 4, title: "Music Size"),
    SortMusicModel(id: 5, title: "By Alphabet (Ascending)"),
    SortMusicModel(id: 6, title: "By Alphabet (Descending)"),
  ];

  static final List<RepeatModeModel> repeatModeList = [
    RepeatModeModel(
      id: 1,
      name: "Shuffle Music",
    ),
    RepeatModeModel(
      id: 2,
      name: "Play Sequentially",
    ),
    RepeatModeModel(
      id: 3,
      name: "Repeat Music",
    ),
  ];
}

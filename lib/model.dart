import 'package:on_audio_query/on_audio_query.dart';

class Directory {
  String name;
  String path;

  Directory({required this.name, required this.path});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Directory &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          path == other.path;

  @override
  int get hashCode => name.hashCode ^ path.hashCode;

  @override
  String toString() {
    return 'Directory{name: $name, path: $path}';
  }
}

class CurrentMusicPlayedModel {
  int position;
  SongModel music;

  CurrentMusicPlayedModel({required this.music, required this.position});

  Map<String, dynamic> toJson() => {
        'position': position,
        'music': music.getMap,
      };

  factory CurrentMusicPlayedModel.fromJson(Map<String, dynamic> json) {
    return CurrentMusicPlayedModel(
      position: json['position'],
      music: SongModel(json['music']),
    );
  }

  @override
  String toString() {
    return 'CurrentMusicPlayedModel(position: $position, music: $music)';
  }
}

class SortMusicModel {
  int id;
  String title;

  SortMusicModel({required this.id, required this.title});
}

class RepeatModeModel {
  int id;
  String name;

  RepeatModeModel({
    required this.id,
    required this.name,
  });
}

class PlaylistModel {
  String id;
  String title;
  List<SongModel> songs;
  int totalSongs;

  PlaylistModel(
      {required this.id,
      required this.title,
      required this.songs,
      required this.totalSongs});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'songs': songs.map((value) => value.getMap).toList(),
        'totalSongs': totalSongs
      };

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
      id: json['id'],
      songs: (json['songs'] as List<dynamic>)
          .map((value) => SongModel(value))
          .toList(),
      title: json['title'],
      totalSongs: json['totalSongs']);

  @override
  String toString() {
    return 'PlaylistModel(id: $id, songs: $songs, title: $title, totalSongs: $totalSongs)';
  }
}

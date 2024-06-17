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
}

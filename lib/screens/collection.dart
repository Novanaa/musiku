import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/components/collection_item.dart';
import 'package:musiku/components/music.dart';
import 'package:musiku/components/placeholder.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/model.dart' as model;
import 'package:musiku/sections/collection/header.dart';
import 'package:musiku/sections/collection/list.dart';
import 'package:musiku/sections/collection/playlist_music.dart';
import 'package:musiku/sections/collection/playlist_screen_options.dart';
import 'package:musiku/utils/common.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: ColorConstants.splashColor),
      child: const Scaffold(
        body: CollectionList(),
        appBar: CollectionHeader(),
      ),
    );
  }
}

class CollectionSearchScreen extends StatefulWidget {
  const CollectionSearchScreen({super.key});

  @override
  State<CollectionSearchScreen> createState() => _CollectionSearchScreenState();
}

class _CollectionSearchScreenState extends State<CollectionSearchScreen> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: collectionSearchScreenAppBar(),
      body: searchCollection(),
    );
  }

  Widget searchCollection() {
    final PlaylistController playlistController = Get.put(PlaylistController());
    final ArtistController artistController = Get.put(ArtistController());
    List<model.PlaylistModel> filteredPlaylist = playlistController.playlist
        .where((value) =>
            value.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    List<ArtistModel> filteredArtist = artistController.artist
        .where((value) =>
            value.artist.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    if (filteredPlaylist.isEmpty && filteredArtist.isEmpty) {
      return const SearchNotFoundPlaceholder();
    }

    return Container(
      margin: const EdgeInsets.all(15),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 35,
        crossAxisSpacing: 15,
        childAspectRatio: 1 / 1.4,
        children: [
          ...filteredPlaylist
              .map((value) => CollectionItemList.playlist(value)),
          ...filteredArtist.map((value) => CollectionItemList.artist(value)),
        ],
      ),
    );
  }

  void onTextfieldChanged(String text) {
    setState(() => keyword = text);
  }

  AppBar collectionSearchScreenAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: ColorConstants.iconColor,
      title: collectionSearchBar(),
      titleSpacing: -0,
    );
  }

  Container collectionSearchBar() {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: TextField(
        onChanged: onTextfieldChanged,
        style: const TextStyle(
            color: ColorConstants.textColor,
            fontWeight: FontWeight.w500,
            fontSize: 13.5),
        cursorColor: ColorConstants.textColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstants.inputColor,
          prefixIcon: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/search.svg"),
            color: ColorConstants.iconColor,
          ),
          hintText: "What are you looking for?",
          hintStyle: const TextStyle(
              color: ColorConstants.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 13.5),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class AddPlaylistSongsScreen extends StatefulWidget {
  const AddPlaylistSongsScreen({super.key});

  @override
  State<AddPlaylistSongsScreen> createState() => _AddPlaylistSongsScreenState();
}

class _AddPlaylistSongsScreenState extends State<AddPlaylistSongsScreen> {
  bool dummyState = false;

  final MusicController musicController = Get.put(MusicController());

  model.PlaylistModel playlist = Get.arguments["playlist"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addPlaylistSongsAppBar(),
      body: addPlaylistSongsList(),
    );
  }

  AppBar addPlaylistSongsAppBar() => AppBar(
        backgroundColor: ColorConstants.headerBackgroundColor,
        foregroundColor: ColorConstants.textColor,
        title: const Text(
          "Add Songs",
          style: TextStyle(
              color: ColorConstants.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      );

  Container addPlaylistSongsList() => Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Obx(() => ListView.builder(
              itemCount: musicController.music.length,
              itemBuilder: (BuildContext context, int index) =>
                  addPlaylistSong(musicController.music[index], context),
            )),
      );

  Opacity addPlaylistSong(SongModel song, BuildContext context) {
    bool isMusicSavedToPlaylist = isMusicAddedToPlaylist(playlist, song);

    return Opacity(
      opacity: isMusicSavedToPlaylist ? 0.6 : 1,
      child: GestureDetector(
        onTap: isMusicSavedToPlaylist
            ? null
            : () {
                handleAddPlaylistSong(song);
              },
        child: Container(
          margin:
              const EdgeInsets.only(top: 11, bottom: 11, left: 15, right: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(song.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15)),
                  const SizedBox(height: 4),
                  Opacity(
                      opacity: 0.8,
                      child: Text(
                        getMusicMetadata(song) ??
                            "Unknown albums - Unkown artist",
                        style: const TextStyle(fontSize: 11.5),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
            ),
            !isMusicSavedToPlaylist
                ? GestureDetector(
                    onTap: () {
                      handleAddPlaylistSong(song);
                    },
                    child: SvgPicture.asset("assets/icons/plus.svg",
                        height: 20, width: 20),
                  )
                : GestureDetector(
                    onTap: null,
                    child: SvgPicture.asset("assets/icons/checklist.svg",
                        height: 20, width: 20),
                  )
          ]),
        ),
      ),
    );
  }

  void handleAddPlaylistSong(SongModel song) {
    final PlaylistController playlistController = Get.put(PlaylistController());

    playlistController.addPlaylistSongs(playlist.id, song);
    setState(() => dummyState = !dummyState);
  }
}

// ignore: must_be_immutable
class ArtistScreen extends StatelessWidget {
  ArtistScreen({super.key});

  ArtistModel artist = Get.arguments["artist"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: artistScreenAppBar(),
      body: Column(
        children: [
          Stack(
            children: [
              artistScreenBanner(),
              artistMetadata(),
            ],
          ),
          musicList()
        ],
      ),
    );
  }

  AppBar artistScreenAppBar() => AppBar(
        foregroundColor: ColorConstants.textColor,
        backgroundColor: ColorConstants.inputColor,
      );

  Positioned artistScreenBanner() => Positioned(
        child: ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorConstants.inputColor,
                ColorConstants.inputColor,
                Colors.transparent
              ],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            decoration: const BoxDecoration(color: ColorConstants.inputColor),
            height: 120,
          ),
        ),
      );

  Container artistMetadata() => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 55, 55, 55),
                        ColorConstants.modalBackgroundColor,
                      ])),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/artist.svg",
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artist.artist == "<unknown>"
                      ? "Unkown artist"
                      : artist.artist,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const Opacity(opacity: 0.8, child: Text("Arist"))
              ],
            )
          ],
        ),
      );

  Expanded musicList() {
    final MusicController musicController = Get.put(MusicController());
    List<SongModel> artistMusicList = musicController.music
        .where((value) => value.artistId == artist.id)
        .toList();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index) => Music(song: artistMusicList[index]),
        itemCount: artistMusicList.length,
      ),
    );
  }
}

// ignore: must_be_immutable
class PlaylistScreen extends StatelessWidget {
  PlaylistScreen({super.key});

  model.PlaylistModel playlist = Get.arguments["playlist"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: playlistScreenAppBar(context),
      body: Column(
        children: [
          Stack(
            children: [
              playlistScreenBanner(),
              playlistMetadata(),
            ],
          ),
          playlistMusicList()
        ],
      ),
    );
  }

  AppBar playlistScreenAppBar(
    BuildContext context,
  ) =>
      AppBar(
        foregroundColor: ColorConstants.textColor,
        backgroundColor: ColorConstants.inputColor,
        actions: [
          IconButton(
              onPressed: () => openPlaylistScreenOptions(context, playlist),
              icon: SvgPicture.asset("assets/icons/music-options.svg"))
        ],
      );

  Positioned playlistScreenBanner() => Positioned(
        child: ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorConstants.inputColor,
                ColorConstants.inputColor,
                Colors.transparent
              ],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            decoration: const BoxDecoration(color: ColorConstants.inputColor),
            height: 120,
          ),
        ),
      );

  Container playlistMetadata() => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 55, 55, 55),
                        ColorConstants.modalBackgroundColor,
                      ])),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/playlist.svg",
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playlist.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const Opacity(opacity: 0.8, child: Text("Playlist"))
              ],
            )
          ],
        ),
      );

  Expanded playlistMusicList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index) => PlaylistMusic(
          song: playlist.songs[index],
          playlist: playlist,
        ),
        itemCount: playlist.songs.length,
      ),
    );
  }
}

class FavoritesMusicScreen extends StatelessWidget {
  FavoritesMusicScreen({super.key});

  final FavoritesMusicController favoritesMusicController =
      Get.put(FavoritesMusicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: favoritesMusicScreenAppBar(context),
      body: Column(
        children: [
          Stack(
            children: [
              favoritesMusicScreenBanner(),
              favoritesMusicMetadata(),
            ],
          ),
          favoritesMusicList()
        ],
      ),
    );
  }

  AppBar favoritesMusicScreenAppBar(BuildContext context) => AppBar(
        foregroundColor: ColorConstants.textColor,
        backgroundColor: ColorConstants.inputColor,
      );

  Positioned favoritesMusicScreenBanner() => Positioned(
        child: ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorConstants.inputColor,
                ColorConstants.inputColor,
                Colors.transparent
              ],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            decoration: const BoxDecoration(color: ColorConstants.inputColor),
            height: 120,
          ),
        ),
      );

  Container favoritesMusicMetadata() => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 55, 55, 55),
                        ColorConstants.modalBackgroundColor,
                      ])),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/heart.svg",
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favorites Music",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Opacity(opacity: 0.8, child: Text("Collection"))
              ],
            )
          ],
        ),
      );

  Expanded favoritesMusicList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index) =>
            Music(song: favoritesMusicController.favoritesMusic[index]),
        itemCount: favoritesMusicController.favoritesMusic.length,
      ),
    );
  }
}

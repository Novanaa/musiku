import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musiku/components/collection_item.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/model.dart' as model;
import 'package:musiku/screens/favorites.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(bottom: 40),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 35,
        crossAxisSpacing: 15,
        childAspectRatio: 1 / 1.4,
        children: [
          favoritesMusicItem(),
          ...playlistItemList(),
          ...artistItemList(),
          addPlaylistItem()
        ],
      ),
    );
  }

  List<CollectionItem> artistItemList() {
    final ArtistController artistController = Get.put(ArtistController());

    return artistController.artist.map((value) => artistItem(value)).toList();
  }

  List<CollectionItem> playlistItemList() {
    final PlaylistController playlistController = Get.put(PlaylistController());

    return playlistController.playlist
        .map((value) => playlistItem(value))
        .toList();
  }

  CollectionItem favoritesMusicItem() {
    return CollectionItem(
      title: "Favorites",
      description: "Collection",
      onTap: () => Get.to(() => const FavoritesMusicScreen(),
          transition: Transition.cupertino),
      iconPath: "assets/icons/heart.svg",
    );
  }

  CollectionItem playlistItem(model.PlaylistModel playlist) {
    return CollectionItem(
      title: playlist.title,
      description: "Playlist",
      // TODO: Implement view single playlist feature
      onTap: () {},
      iconPath: "assets/icons/playlist.svg",
    );
  }

  CollectionItem artistItem(ArtistModel artist) {
    return CollectionItem(
      title: artist.artist,
      borderRadius: 1000,
      description: "Artist",
      // TODO: Implement view single artist feature
      onTap: () {},
      iconPath: "assets/icons/artist.svg",
    );
  }

  CollectionItem addPlaylistItem() {
    return CollectionItem(
      title: "Add Playlist",
      // TODO: Implement add playlist feature
      onTap: () {},
      iconPath: "assets/icons/plus.svg",
    );
  }
}

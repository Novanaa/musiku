import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musiku/components/add_playlist.dart';
import 'package:musiku/components/collection_item.dart';
import 'package:musiku/screens/favorites.dart';

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
          ...CollectionItemList.playlistItemList(),
          ...CollectionItemList.artistItemList(),
          addPlaylistItem(context)
        ],
      ),
    );
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

  CollectionItem addPlaylistItem(BuildContext context) {
    return CollectionItem(
      title: "Add Playlist",
      onTap: () => openAddPlaylistDrawer(context),
      iconPath: "assets/icons/plus.svg",
    );
  }
}
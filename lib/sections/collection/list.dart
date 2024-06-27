import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        crossAxisSpacing: 10,
        childAspectRatio: 1 / 1.4,
        children: [favoritesMusicItem()],
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

  CollectionItem playlistItem(String title) {
    return CollectionItem(
      title: title,
      description: "Playlist",
      // TODO: Implement view single playlist feature
      onTap: () {},
      iconPath: "assets/icons/playlist.svg",
    );
  }

  CollectionItem artistItem(String title) {
    return CollectionItem(
      title: title,
      borderRadius: 1000,
      description: "Artist",
      // TODO: Implement view single playlist feature
      onTap: () {},
      iconPath: "assets/icons/artist.svg",
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musiku/components/collection_item.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(bottom: 40),
      child: Obx(
        () => GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 35,
          crossAxisSpacing: 15,
          childAspectRatio: 1 / 1.4,
          children: [
            CollectionItemList.favoritesMusicItem(),
            ...CollectionItemList.playlistItemList(),
            ...CollectionItemList.artistItemList(),
            CollectionItemList.addPlaylistItem(context)
          ],
        ),
      ),
    );
  }
}

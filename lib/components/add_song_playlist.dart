import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:musiku/components/collection_item.dart';
import 'package:musiku/constants/color.dart';

void openAddSongPlaylistDrawer(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => const AddSongPlaylistDrawer(),
      isScrollControlled: true,
      backgroundColor: ColorConstants.headerBackgroundColor);
}

class AddSongPlaylistDrawer extends StatelessWidget {
  const AddSongPlaylistDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        padding:
            const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 15),
        child: Column(
          children: [addSongPlaylistHeader(), addSongPlaylistListItem(context)],
        ));
  }

  Center addSongPlaylistHeader() => const Center(
        child: Text("Save Music To Playlist",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      );

  Expanded addSongPlaylistListItem(BuildContext context) => Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: Obx(() => GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 25,
                crossAxisSpacing: 15,
                childAspectRatio: 1 / 1.4,
                children: [
                  ...CollectionItemList.playlistItemList(),
                  CollectionItemList.addPlaylistItem(context)
                ],
              )),
        ),
      );
}

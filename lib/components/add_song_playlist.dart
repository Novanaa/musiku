import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musiku/components/collection_item.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/model.dart' as model;
import 'package:musiku/utils/actions.dart';
import 'package:musiku/utils/common.dart';
import 'package:on_audio_query/on_audio_query.dart';

void openAddSongPlaylistDrawer(BuildContext context, SongModel music) {
  showModalBottomSheet(
      context: context,
      builder: (context) => AddSongPlaylistDrawer(song: music),
      isScrollControlled: true,
      backgroundColor: ColorConstants.headerBackgroundColor);
}

class AddSongPlaylistDrawer extends StatelessWidget {
  final SongModel song;
  const AddSongPlaylistDrawer({super.key, required this.song});

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
                  ...playlistItemList(),
                  CollectionItemList.addPlaylistItem(context)
                ],
              )),
        ),
      );

  Opacity playlistItem(model.PlaylistModel playlist) {
    return Opacity(
      opacity: isMusicAddedToPlaylist(playlist, song) ? 0.6 : 1,
      child: CollectionItem(
        title: playlist.title,
        description: "Playlist",
        onTap: isMusicAddedToPlaylist(playlist, song)
            ? () {}
            : () {
                addPlaylistSong(playlist.id, song);
              },
        iconPath: "assets/icons/playlist.svg",
      ),
    );
  }

  List<Opacity> playlistItemList() {
    final PlaylistController playlistController = Get.put(PlaylistController());

    return playlistController.playlist
        .map((value) => playlistItem(value))
        .toList();
  }
}

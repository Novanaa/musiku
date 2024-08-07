import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/model.dart';
import 'package:musiku/screens/collection.dart';
import 'package:musiku/sections/collection/edit_playlist.dart';
import 'package:musiku/utils/actions.dart';

void openPlaylistScreenOptions(BuildContext context, PlaylistModel playlist) {
  showModalBottomSheet(
      context: context,
      builder: (context) => PlaylistScreenOptionsDrawer(playlist: playlist),
      isScrollControlled: true,
      backgroundColor: ColorConstants.modalBackgroundColor);
}

class PlaylistScreenOptionsDrawer extends StatelessWidget {
  const PlaylistScreenOptionsDrawer({super.key, required this.playlist});
  final PlaylistModel playlist;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      height: 200,
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Get.to(() => const AddPlaylistSongsScreen(),
                transition: Transition.cupertino,
                arguments: {'playlist': playlist}),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/playlist.svg",
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Add Playlist Songs",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => openEditPlaylistNameDrawer(context, playlist),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/rewrite.svg",
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Edit Playlist Name",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              removePlaylist(playlist.id);
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/trash.svg",
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Remove Playlist",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.destructiveColor),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

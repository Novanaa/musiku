import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musiku/constants/color.dart';

void openPlaylistScreenOptions(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => const PlaylistScreenOptionsDrawer(),
      isScrollControlled: true,
      backgroundColor: ColorConstants.modalBackgroundColor);
}

class PlaylistScreenOptionsDrawer extends StatelessWidget {
  const PlaylistScreenOptionsDrawer({super.key});

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
            // TODO: Implement add playlist songs feature
            onTap: () {},
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
            // TODO: Implement edit playlist name feature
            onTap: () {},
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
            // TODO: Implement remove playlist feature
            onTap: () {},
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/utils/actions.dart';

void openAddPlaylistDrawer(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => const AddPlaylistDrawer(),
      isScrollControlled: true,
      backgroundColor: ColorConstants.modalBackgroundColor);
}

class AddPlaylistDrawer extends StatefulWidget {
  const AddPlaylistDrawer({super.key});

  @override
  State<AddPlaylistDrawer> createState() => _AddPlaylistDrawerState();
}

class _AddPlaylistDrawerState extends State<AddPlaylistDrawer> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      margin: MediaQuery.of(context).viewInsets,
      padding: const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 15),
      child: Column(
        children: [addPlaylistHeader(), addPlaylistForm(), addPlaylistAction()],
      ),
    );
  }

  Center addPlaylistHeader() {
    return const Center(
      child: Text("Add Playlist",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }

  Container addPlaylistForm() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: TextField(
          onChanged: (text) => setState(() => keyword = text),
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
              icon: SvgPicture.asset("assets/icons/playlist.svg"),
              color: ColorConstants.iconColor,
            ),
            hintText: "Input your playlist title here!",
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
        ));
  }

  Container addPlaylistAction() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: ColorConstants.backgroundColor,
                        fontWeight: FontWeight.w500),
                  ))),
          const SizedBox(width: 10),
          Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    addPlaylist(keyword);
                  },
                  style: const ButtonStyle(enableFeedback: true),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        color: ColorConstants.backgroundColor,
                        fontWeight: FontWeight.w500),
                  ))),
        ],
      ),
    );
  }
}

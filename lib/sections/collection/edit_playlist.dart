import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/model.dart';
import 'package:musiku/utils/actions.dart';

void openEditPlaylistNameDrawer(BuildContext context, PlaylistModel playlist) {
  showModalBottomSheet(
      context: context,
      builder: (context) => EditPlaylistName(playlist: playlist),
      isScrollControlled: true,
      backgroundColor: ColorConstants.modalBackgroundColor);
}

class EditPlaylistName extends StatefulWidget {
  final PlaylistModel playlist;

  const EditPlaylistName({super.key, required this.playlist});

  @override
  State<EditPlaylistName> createState() => _EditPlaylistNameState();
}

class _EditPlaylistNameState extends State<EditPlaylistName> {
  String keyword = "";

  late final TextEditingController controller =
      TextEditingController(text: widget.playlist.title);

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      margin: MediaQuery.of(context).viewInsets,
      padding: const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 15),
      child: Column(
        children: [
          editPlaylistNameHeader(),
          editPlaylistNameForm(),
          editPlaylistNameActions()
        ],
      ),
    );
  }

  Center editPlaylistNameHeader() {
    return const Center(
      child: Text("Edit Playlist Name",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }

  Container editPlaylistNameForm() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: TextField(
          controller: controller,
          onChanged: (text) {
            setState(() => keyword = text);
          },
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
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ));
  }

  Container editPlaylistNameActions() {
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
                    editPlaylistName(widget.playlist.id, keyword);
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

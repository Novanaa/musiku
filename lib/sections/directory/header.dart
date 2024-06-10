import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/screens/directory.dart';
import 'package:musiku/sections/directory/info.dart';

class DirectoryHeader extends StatelessWidget implements PreferredSizeWidget {
  const DirectoryHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConstants.backgroundColor,
      title: directoryHeaderTitle(),
      actions: [
        directoryActionSearchButton(),
        directoryActionInfoButton(context)
      ],
    );
  }

  IconButton directoryActionInfoButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDirectoryActionInfoBottomSheetModal(context);
        },
        icon: SvgPicture.asset("assets/icons/info.svg"));
  }

  Future<dynamic> showDirectoryActionInfoBottomSheetModal(
      BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => const DirectoryInformation(),
        isScrollControlled: true,
        backgroundColor: ColorConstants.modalBackgroundColor);
  }

  IconButton directoryActionSearchButton() {
    return IconButton(
        onPressed: () {
          Get.to(const DirectorySearchScreen(),
              transition: Transition.cupertino);
        },
        icon: SvgPicture.asset("assets/icons/search.svg"));
  }

  Text directoryHeaderTitle() {
    return const Text(
      "Directory",
      style: TextStyle(
          color: ColorConstants.textColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w700,
          fontSize: 17),
    );
  }
}

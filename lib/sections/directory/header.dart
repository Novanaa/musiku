import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musiku/constants/color.dart';

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
      actions: [directoryActionSearchButton(), directoryActionInfoButton()],
    );
  }

  IconButton directoryActionInfoButton() {
    return IconButton(
        onPressed: () {}, icon: SvgPicture.asset("assets/icons/info.svg"));
  }

  IconButton directoryActionSearchButton() {
    return IconButton(
        onPressed: () {}, icon: SvgPicture.asset("assets/icons/search.svg"));
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

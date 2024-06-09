import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musiku/constants/color.dart';

class HomeScreenHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback openDrawer;

  const HomeScreenHeader({super.key, required this.openDrawer});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConstants.backgroundColor,
      actions: [
        IconButton(
            onPressed: openDrawer,
            splashColor: ColorConstants.rippleColor,
            icon: SvgPicture.asset("assets/icons/menu.svg",
                width: 25, height: 25))
      ],
      titleTextStyle: const TextStyle(
          color: ColorConstants.textColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w700,
          fontSize: 17),
      title: const Text("Musiku"),
    );
  }
}

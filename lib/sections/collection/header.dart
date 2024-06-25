import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/screens/collection.dart';

class CollectionHeader extends StatelessWidget implements PreferredSizeWidget {
  const CollectionHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.backgroundColor,
      elevation: 0,
      title: const Text(
        "Your Collection",
        style: TextStyle(
            color: ColorConstants.textColor,
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () => Get.to(const CollectionSearchScreen(),
              transition: Transition.cupertino),
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/plus.svg"),
          // TODO: Implement add user collection drawer
          onPressed: () {},
        )
      ],
    );
  }
}

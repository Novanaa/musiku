import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:musiku/components/add_playlist.dart';
import 'package:musiku/components/icon.dart';
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
        CustomIconButton(
          data: Iconsax.search_normal_copy,
          size: 23,
          onPressed: () => Get.to(const CollectionSearchScreen(),
              transition: Transition.cupertino),
        ),
        CustomIconButton(
          data: Iconsax.add_copy,
          onPressed: () => openAddPlaylistDrawer(context),
          size: 30,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:musiku/components/icon.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/sections/home/bottom_sheet.dart';

class MusicListHeader extends StatelessWidget {
  const MusicListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: ColorConstants.borderColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          musicListHeaderText(),
          Row(children: [
            musicListHeaderRepeatModeOptions(context),
            const SizedBox(
              width: 12,
            ),
            musicListHeaderListOptions(context),
          ])
        ],
      ),
    );
  }

  InkWell musicListHeaderRepeatModeOptions(BuildContext context) {
    return InkWell(
        splashColor: ColorConstants.splashColor,
        onTap: () => openRepeatModeBottomSheet(context),
        child: const CustomIcon(
          data: Iconsax.music_filter,
          size: 21,
        ));
  }

  InkWell musicListHeaderListOptions(BuildContext context) {
    return InkWell(
        splashColor: ColorConstants.splashColor,
        onTap: () => openSortMusicBottomSheet(context),
        child: SvgPicture.asset(
          "assets/icons/list-options.svg",
        ));
  }

  Text musicListHeaderText() {
    return const Text("Listen to everything!",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5));
  }
}

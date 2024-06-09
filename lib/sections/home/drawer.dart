import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musiku/constants/color.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.modalBackgroundColor,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [drawerMenuHeader(), drawerMenu(context)],
        ),
      ),
    );
  }

  Padding drawerMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          // Placeholder for right now!
          drawerMenuItem("Support Creator", "assets/icons/sparkles.svg", () {}),
          drawerMenuItem("Give Feedback", "assets/icons/heart.svg", () {}),
          drawerMenuItem("Application version", "assets/icons/info.svg", () {}),
        ],
      ),
    );
  }

  InkWell drawerMenuItem(String title, String asset, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, top: 10, right: 10, bottom: 10),
        child: Row(
          children: [
            SvgPicture.asset(asset),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Padding drawerMenuHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: Column(
        children: [
          Text(
            "Musiku",
            style: TextStyle(
                color: ColorConstants.textColor,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                fontSize: 17),
          )
        ],
      ),
    );
  }
}

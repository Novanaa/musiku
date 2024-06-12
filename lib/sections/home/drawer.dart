import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musiku/constants/color.dart';
import 'package:url_launcher/url_launcher.dart';

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
          drawerMenuItem("Support Creator", "assets/icons/sparkles.svg", () {
            navigateSupportCreatorPage();
          }),
          drawerMenuItem("Give Feedback", "assets/icons/heart.svg", () {
            navigateGiveFeedbackPage();
          }),
          drawerMenuItem("Application version", "assets/icons/info.svg", () {
            showApplicationVersion(context);
          }),
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

  Future<void> navigateGiveFeedbackPage() async {
    // Placeholder url for now, change it later!
    final Uri page = Uri.parse('https://www.buymeacoffee.com/kadeknova');

    if (!await launchUrl(page)) {
      throw Exception('Could not launch $page');
    }
  }

  Future<void> navigateSupportCreatorPage() async {
    final Uri page = Uri.parse('https://www.buymeacoffee.com/kadeknova');

    if (!await launchUrl(page)) {
      throw Exception('Could not launch $page');
    }
  }

  void showApplicationVersion(BuildContext context) {
    TextButton okButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("OK"));

    AlertDialog alert = AlertDialog(
      backgroundColor: ColorConstants.modalBackgroundColor,
      title: const Text("Application version"),
      actions: [okButton],
      content: const Text("1.0.0"),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

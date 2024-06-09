import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musiku/constants/color.dart';

class HomeCards extends StatelessWidget {
  const HomeCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            musicHeaderListItem(
                "Leave a star!",
                "Hey there! could you give me a star? i will appreciate that!",
                "assets/icons/sparkles.svg"),
            const SizedBox(
              width: 12,
            ),
            musicHeaderListItem("Report some bugs!",
                "Have an issues while using Musiku?", "assets/icons/bug.svg"),
            const SizedBox(
              width: 12,
            ),
            musicHeaderListItem(
                "Suggest a feature?",
                "Have an idea? contribute to Musiku app development!",
                "assets/icons/file-json.svg"),
          ],
        ),
      ),
    );
  }

  Container musicHeaderListItem(
      String title, String description, String assetName) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.cardBackgroundColor),
      padding: const EdgeInsets.all(12),
      width: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            assetName,
            height: 32,
            width: 32,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Opacity(
            opacity: 0.8,
            child: Text(
              description,
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

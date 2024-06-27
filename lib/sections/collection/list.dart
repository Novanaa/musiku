import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musiku/constants/color.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          favoritesMusicItem(),
        ],
      ),
    );
  }

  InkWell favoritesMusicItem() {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      // TODO: Implement view favorites music feature
      onTap: () {},
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 55, 55, 55),
                  ColorConstants.modalBackgroundColor,
                ])),
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/heart.svg",
            width: 35,
            height: 35,
          ),
        ),
      ),
    );
  }
}

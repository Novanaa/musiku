import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/model.dart';
import 'package:musiku/screens/directory.dart';

class DirectoryItem extends StatelessWidget {
  final Directory item;

  const DirectoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => DirectoryScreen(),
            transition: Transition.cupertino, arguments: {'directory': item});
      },
      child: Container(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/folder.svg",
              width: 35,
              height: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14.5),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Opacity(
                      opacity: 0.8,
                      child: Text(
                        item.path,
                        style: const TextStyle(fontSize: 11.5),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

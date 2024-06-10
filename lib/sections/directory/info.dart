import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musiku/constants/color.dart';

class DirectoryInformation extends StatelessWidget {
  const DirectoryInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(top: 30, bottom: 20, right: 20, left: 20),
      child: ListView(
        children: [
          directoryInformationHeader(context),
          const SizedBox(
            height: 10,
          ),
          directoryInformationItems(context)
        ],
      ),
    );
  }

  Row directoryInformationItems(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorConstants.borderColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/icons/music.svg",
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text("Music",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                const Opacity(
                  opacity: 0.8,
                  child: Text(
                    // Placeholder for right now, change it with real data later on!
                    "0 items found",
                    style: TextStyle(fontSize: 12.5),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorConstants.borderColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/icons/folder.svg",
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text("Directory",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                const Opacity(
                  opacity: 0.8,
                  child: Text(
                    // Placeholder for right now, change it with real data later on!
                    "0 items found",
                    style: TextStyle(fontSize: 12.5),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Container directoryInformationHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConstants.borderColor)),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/chart-pie.svg",
            width: 40,
            height: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Directory Information",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              Opacity(
                opacity: 0.8,
                child: Text("Discover your music statistics here!",
                    style: TextStyle(fontSize: 11)),
              )
            ],
          )
        ],
      ),
    );
  }
}

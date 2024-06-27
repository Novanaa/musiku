import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/model.dart' as model;
import 'package:on_audio_query/on_audio_query.dart';

class CollectionItem extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String title;
  final double? borderRadius;
  final String? description;
  const CollectionItem({
    super.key,
    required this.onTap,
    required this.iconPath,
    required this.title,
    this.borderRadius,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 55, 55, 55),
                      ColorConstants.modalBackgroundColor,
                    ])),
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
              onTap: onTap,
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 35,
                  height: 35,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              Opacity(
                opacity: 0.8,
                child: Text(
                  description ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CollectionItemList {
  static CollectionItem artist(ArtistModel artist) {
    return CollectionItem(
      title: artist.artist == "<unknown>" ? "Unkown artist" : artist.artist,
      borderRadius: 1000,
      description: "Artist",
      // TODO: Implement view single artist feature
      onTap: () {},
      iconPath: "assets/icons/artist.svg",
    );
  }

  static CollectionItem playlist(model.PlaylistModel playlist) {
    return CollectionItem(
      title: playlist.title,
      description: "Playlist",
      // TODO: Implement view single playlist feature
      onTap: () {},
      iconPath: "assets/icons/playlist.svg",
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/components/collection_item.dart';
import 'package:musiku/components/placeholder.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/model.dart' as model;
import 'package:musiku/sections/collection/header.dart';
import 'package:musiku/sections/collection/list.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: ColorConstants.splashColor),
      child: const Scaffold(
        body: CollectionList(),
        appBar: CollectionHeader(),
      ),
    );
  }
}

class CollectionSearchScreen extends StatefulWidget {
  const CollectionSearchScreen({super.key});

  @override
  State<CollectionSearchScreen> createState() => _CollectionSearchScreenState();
}

class _CollectionSearchScreenState extends State<CollectionSearchScreen> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: collectionSearchScreenAppBar(),
      body: searchCollection(),
    );
  }

  Widget searchCollection() {
    final PlaylistController playlistController = Get.put(PlaylistController());
    final ArtistController artistController = Get.put(ArtistController());
    List<model.PlaylistModel> filteredPlaylist = playlistController.playlist
        .where((value) =>
            value.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    List<ArtistModel> filteredArtist = artistController.artist
        .where((value) =>
            value.artist.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    if (filteredPlaylist.isEmpty && filteredArtist.isEmpty) {
      return const SearchNotFoundPlaceholder();
    }

    return Container(
      margin: const EdgeInsets.all(15),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 35,
        crossAxisSpacing: 15,
        childAspectRatio: 1 / 1.4,
        children: [
          ...filteredPlaylist
              .map((value) => CollectionItemList.playlist(value)),
          ...filteredArtist.map((value) => CollectionItemList.artist(value)),
        ],
      ),
    );
  }

  void onTextfieldChanged(String text) {
    setState(() => keyword = text);
  }

  AppBar collectionSearchScreenAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: ColorConstants.iconColor,
      title: collectionSearchBar(),
      titleSpacing: -0,
    );
  }

  Container collectionSearchBar() {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: TextField(
        onChanged: onTextfieldChanged,
        style: const TextStyle(
            color: ColorConstants.textColor,
            fontWeight: FontWeight.w500,
            fontSize: 13.5),
        cursorColor: ColorConstants.textColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstants.inputColor,
          prefixIcon: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/search.svg"),
            color: ColorConstants.iconColor,
          ),
          hintText: "What are you looking for?",
          hintStyle: const TextStyle(
              color: ColorConstants.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 13.5),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

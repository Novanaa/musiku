import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/sections/collection/header.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: ColorConstants.splashColor),
      child: const Scaffold(
        body: Center(child: Text("collection")),
        appBar: CollectionHeader(),
      ),
    );
  }
}

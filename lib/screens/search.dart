import 'package:flutter/material.dart';
import 'package:musiku/components/placeholder.dart';
import 'package:musiku/sections/search/search_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SearchScreenBar(
            // TODO: Implement later on!!
            onTextChanged: (String text) {},
          ),
          const SearchWelcomeScreen()
        ],
      ),
    );
  }
}

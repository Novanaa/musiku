import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchWelcomeScreen extends StatelessWidget {
  const SearchWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/search-not-found.svg"),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Hey! What's up?",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.60,
            child: const Opacity(
              opacity: 0.8,
              child: Text(
                "Type something in top search bar and see the magic!",
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EmptyMusicPlaceholder extends StatelessWidget {
  const EmptyMusicPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/empty-music-placeholder.svg",
            width: 120,
            height: 120,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text("Got any tunes on your phone?",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const Opacity(
              opacity: 0.8,
              child: Text(
                "How about we add some tunes to your phone? It's feeling a bit too quiet in here!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchNotFoundPlaceholder extends StatelessWidget {
  const SearchNotFoundPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/cat-box.svg",
            width: 120,
            height: 120,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text("Not results found",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const Opacity(
              opacity: 0.8,
              child: Text(
                "Requested items cannot be found, try searching something else.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

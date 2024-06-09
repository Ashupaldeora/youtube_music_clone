import 'package:flutter/material.dart';
import 'package:youtube_music_clone/screens/home/view/home_screen.dart';

class SliverRemainingScreen extends StatelessWidget {
  const SliverRemainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
        sliverFillRemaining: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "START RADIO BASED ON A SONG",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          // ...List.generate(
          //     15,
          //     (index) => Container(
          //           height: 100,
          //           color: Colors.blue,
          //         ))
        ],
      ),
    ));
  }
}

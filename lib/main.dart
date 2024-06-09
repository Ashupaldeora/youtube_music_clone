import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_music_clone/screens/home/view/home_screen.dart';

void main() {
  runApp(const YoutubeMusic());
}

class YoutubeMusic extends StatelessWidget {
  const YoutubeMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music_clone/screens/home/models/quick_picks.dart';

import '../../home/provider/home.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.black],
        ),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Song",
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "EuclidRegular",
                  fontSize: 15),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.cast,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          AnimatedContainer(
            height: 350,
            width: 350,
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(quickPicks[0].imageUrl))),
          )
        ],
      ),
    );
  }
}

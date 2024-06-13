import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music_clone/screens/home/models/quick_picks.dart';

import '../../home/provider/home.dart';
import 'components/played_save_share.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff3d1a09),
            Color(0xff3d1a09),
            Color(0xff2c1307),
            Color(0xff1c0c05),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            color:
                Colors.transparent, // Make sure the background is transparent
            padding: EdgeInsets.symmetric(horizontal: 8.0), // Optional padding
            child: Stack(
              children: [
                // Leading IconButton
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Title
                Center(
                  child: Text(
                    "Song",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "EuclidRegular",
                      fontSize: 15,
                    ),
                  ),
                ),

                // Actions
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cast,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      height: 350,
                      width: 350,
                      duration: Duration(seconds: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(quickPicks[0].imageUrl))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    quickPicks[0].songName,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Text(
                    quickPicks[0].artistName,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          const PlayedSaveShare(),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/icons/svgviewer-output.svg",
                    height: 20,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_previous_rounded,
                    size: 35,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.play_circle_fill,
                    size: 90,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_next,
                    size: 35,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/icons/loop.svg",
                    height: 27,
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "UP NEXT",
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "LYRICS",
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "RELATED",
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

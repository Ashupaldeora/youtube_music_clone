import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music_clone/screens/home/models/covers_remixes.dart';
import 'package:youtube_music_clone/screens/home/models/quick_picks.dart';
import 'package:youtube_music_clone/screens/music_player/provider/music.dart';

import '../../home/provider/home.dart';
import 'components/played_save_share.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key, this.controller});
  final controller;
  @override
  Widget build(BuildContext context) {
    final providerTrue = Provider.of<MusicProvider>(context);
    final providerFalse = Provider.of<MusicProvider>(context, listen: false);
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
                    onPressed: () {
                      controller.hide();
                    },
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
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<MusicProvider>(
                      builder: (context, music, child) {
                        return AnimatedContainer(
                          height: 350,
                          width: 350,
                          duration: Duration(seconds: 1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage((music.isQuickPicks &&
                                          !music.isPlayingFromApi)
                                      ? quickPicks[
                                              music.currentPlayingMusicIndex]
                                          .imageUrl
                                      : music.isPlayingFromApi
                                          ? music.apiClickedSongs['image']
                                              .toString()
                                          : coversData[music
                                                  .currentPlayingMusicIndex]
                                              .imageUrl))),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    (providerTrue.isQuickPicks &&
                            !providerTrue.isPlayingFromApi)
                        ? quickPicks[providerTrue.currentPlayingMusicIndex]
                            .songName
                        : providerTrue.isPlayingFromApi
                            ? providerTrue.apiClickedSongs['songName']
                            : coversData[providerTrue.currentPlayingMusicIndex]
                                .songName,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Text(
                    (providerTrue.isQuickPicks &&
                            !providerTrue.isPlayingFromApi)
                        ? quickPicks[providerTrue.currentPlayingMusicIndex]
                            .artistName
                        : providerTrue.isPlayingFromApi
                            ? providerTrue.apiClickedSongs['singerName']
                            : coversData[providerTrue.currentPlayingMusicIndex]
                                .artistName,
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
            height: 25,
          ),
          Consumer<MusicProvider>(
            builder: (context, provider, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SliderTheme(
                data: SliderThemeData(
                  thumbColor: Colors.white,
                  trackHeight: 1.5,
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
                ),
                child: Slider(
                  value: provider.currentPosition.inMilliseconds.toDouble(),
                  min: 0.0,
                  max: provider.totalDuration.inMilliseconds.toDouble(),
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey.shade700,
                  onChanged: (value) {
                    provider.assetsAudioPlayer
                        .seek(Duration(milliseconds: value.toInt()));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  providerFalse.formatDuration(providerTrue.currentPosition),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  providerTrue.formatDuration(providerTrue.totalDuration),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Consumer<MusicProvider>(
            builder: (context, value, child) => Row(
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
                    onPressed: () {
                      providerFalse.updatePlaying();
                    },
                    icon: Icon(
                      value.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle_fill,
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

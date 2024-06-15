import 'package:carousel_slider/carousel_slider.dart';
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
            providerTrue.secondaryColor,
            providerTrue.secondaryColor,
            providerTrue.backgroundColor,
            providerTrue.thirdColor,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 70,
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
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 370,
                width: double.infinity,
                child: CarouselSlider.builder(
                  carouselController: providerTrue.controller,
                  options: CarouselOptions(
                    height: 370,
                    viewportFraction: 1.2,
                    onPageChanged: (index, reason) {
                      providerFalse.updateLoop(true);
                      providerFalse.toggleLooping();

                      if (reason == CarouselPageChangedReason.manual) {
                        providerFalse.playWhenCarouselChanged(index);
                        print(
                            "Carousel onPageChanged: $reason ------------------------------------------------------------------------");
                      }
                    },
                  ),
                  itemCount: (providerTrue.playlistSongs.isEmpty)
                      ? 0
                      : providerTrue.playlistSongs.length,
                  itemBuilder: (context, index, realIndex) => AnimatedContainer(
                    height: 370,
                    width: 370,
                    duration: Duration(seconds: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: providerTrue.playlistSongs.isEmpty
                            ? null
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    providerTrue.playlistSongs[index].image))),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  height: 27,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    providerTrue.playlistSongs.isEmpty
                        ? ""
                        : providerTrue
                            .playlistSongs[providerTrue.currentIndex].song,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                child: SizedBox(
                  height: 23,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    providerTrue.playlistSongs.isEmpty
                        ? ""
                        : providerTrue
                            .playlistSongs[providerTrue.currentIndex].singers,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          const PlayedSaveShare(),
          SizedBox(
            height: 25,
          ),
          Consumer<MusicProvider>(builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
            );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(providerFalse.formatDuration(providerTrue.currentPosition),
                    style: Theme.of(context).textTheme.labelSmall),
                Text(
                  providerTrue.formatDuration(providerTrue.totalDuration),
                  style: Theme.of(context).textTheme.labelSmall,
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
                    onPressed: () {
                      providerFalse.playPreviousPlaylistSong();
                    },
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
                    onPressed: () {
                      providerFalse.playNextPlaylistSong();
                    },
                    icon: Icon(
                      Icons.skip_next,
                      size: 35,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      providerFalse.toggleLooping();
                    },
                    icon: SvgPicture.asset(
                      providerTrue.isLooping
                          ? "assets/icons/loop-1-svgrepo-com.svg"
                          : "assets/icons/loop.svg",
                      height: 27,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Spacer(),
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
          ),
          Spacer(),
        ],
      ),
    );
  }
}

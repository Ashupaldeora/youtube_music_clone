import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music_clone/screens/home/models/charts.dart';
import 'package:youtube_music_clone/screens/home/view/components/quick_picks_section.dart';
import 'package:youtube_music_clone/screens/home/view/components/quick_picks_songs.dart';
import 'package:youtube_music_clone/screens/home/view/home_screen.dart';

import '../../models/quick_picks.dart';
import '../../provider/home.dart';
import 'charts_sections.dart';

class SliverRemainingScreen extends StatelessWidget {
  SliverRemainingScreen({super.key});
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
        ),
        QuickPicksSection(carouselController: _carouselController),
        Charts(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Covers and remixes",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    side: BorderSide(color: Colors.grey.shade800, width: 1),
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Reduce tap target size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    // Define your onPressed action here
                  },
                  child: Text(
                    "Play all",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
            ],
          ),
        ),
        CarouselSlider(
          carouselController: _carouselController,
          items: buildSongPages(context, false),
          options: CarouselOptions(
            height: 390,
            padEnds: false,

            viewportFraction:
                0.86, // Adjust this value for visibility from the right
            enableInfiniteScroll: false,
            autoPlay: false,
          ),
        ),
      ],
    );
  }
}

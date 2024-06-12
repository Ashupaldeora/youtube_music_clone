import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:youtube_music_clone/screens/home/view/components/quick_picks_songs.dart';

class QuickPicksSection extends StatelessWidget {
  const QuickPicksSection({
    super.key,
    required CarouselController carouselController,
  }) : _carouselController = carouselController;

  final CarouselController _carouselController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "START RADIO BASED ON A SONG",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quick Picks",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
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
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CarouselSlider(
          carouselController: _carouselController,
          items: buildSongPages(context, true),
          options: CarouselOptions(
            height: 380,
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

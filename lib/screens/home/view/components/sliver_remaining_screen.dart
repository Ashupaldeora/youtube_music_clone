import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:youtube_music_clone/screens/home/view/home_screen.dart';

class SliverRemainingScreen extends StatelessWidget {
  SliverRemainingScreen({super.key});
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return HomeScreen(
        sliverFillRemaining: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "START RADIO BASED ON A SONG",
                style: Theme.of(context).textTheme.bodySmall,
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
        CarouselSlider(
          carouselController: _carouselController,
          items: [
            Column(
              children: [
                ...List.generate(
                  4,
                  (index) => Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10), // Add some vertical padding
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(
                            width:
                                15), // Add some spacing between the image and text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Song name",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Artist",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
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
                ),
              ],
            ),
            Container(
              color: Colors.yellow,
            )
          ],
          options: CarouselOptions(
            height: 410,
            padEnds: false,
            viewportFraction:
                0.85, // Adjust this value for visibility from the right
            enableInfiniteScroll: false,
            autoPlay: false,
          ),
        )
        // ...List.generate(
        //     15,
        //     (index) => Container(
        //           height: 100,
        //           color: Colors.blue,
        //         ))
      ],
    ));
  }
}

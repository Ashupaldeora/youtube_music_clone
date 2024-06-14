import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:we_slide/we_slide.dart';
import 'package:youtube_music_clone/screens/home/models/quick_picks.dart';
import 'package:youtube_music_clone/screens/music_player/provider/music.dart';

import '../../music_player/view/music_screen.dart';
import '../models/covers_remixes.dart';
import '../provider/home.dart';
import 'components/bottom_bar.dart';
import 'components/my_appbar.dart';
import 'components/scroll_detector.dart';
import 'components/sliver_remaining_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _controller = WeSlideController();
    final providerTrue = Provider.of<HomeProvider>(context);
    final musicProviderTrue = Provider.of<MusicProvider>(context);
    final musicProviderFalse =
        Provider.of<MusicProvider>(context, listen: false);

    final providerFalse = Provider.of<HomeProvider>(context, listen: false);
    final ScrollController _scrollController = ScrollDetector.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WeSlide(
        parallax: true,
        hideAppBar: true,
        hideFooter: true,
        parallaxOffset: 0.3,
        panelMinSize: 140,
        footerHeight: 70,
        controller: _controller,
        panelMaxSize: MediaQuery.of(context).size.height,
        panel: MusicScreen(
          controller: _controller,
        ),
        panelHeader: Stack(
          children: [
            Container(
                height: 70,
                decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade500, width: 1)),
                  color: Color(0xff1d1d1d),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 10, right: 5),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: musicProviderTrue.playlistSongs.isEmpty
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(musicProviderTrue
                                  .playlistSongs[musicProviderTrue.currentIndex]
                                  .image)),
                    ),
                  ),
                  title: Text(
                    musicProviderTrue.playlistSongs.isEmpty
                        ? ""
                        : musicProviderTrue
                            .playlistSongs[musicProviderTrue.currentIndex].song,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  subtitle: Text(
                    musicProviderTrue.playlistSongs.isEmpty
                        ? ""
                        : musicProviderTrue
                            .playlistSongs[musicProviderTrue.currentIndex]
                            .singers,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.cast,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              musicProviderFalse.updatePlaying();
                            },
                            icon: Icon(
                              musicProviderTrue.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                )),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Consumer<MusicProvider>(
                builder: (context, provider, child) => SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 0.8,
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                    thumbShape: SliderComponentShape.noThumb,
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
            // Positioned(
            //     bottom: 0,
            //     child: Container(
            //       height: 2,
            //       width: 30,

            //       color: Colors.grey,
            //     )),
          ],
        ),
        footer: Container(decoration: BoxDecoration(), child: BottomBar()),
        body: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
          return RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1));
              Provider.of<HomeProvider>(context, listen: false)
                  .updateGradientOnRefresh();
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                MyAppBar(
                  homeProvider: homeProvider,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            !homeProvider.hasScrolled
                                ? Provider.of<HomeProvider>(context)
                                    .currentGradient['blendColor']
                                : Colors.black12,
                            // Colors.black.withOpacity(0.3),
                            Colors.black,
                            Colors.black,
                            Colors.black
                          ])),
                      child: SliverRemainingScreen()),
                ),
              ],
            ),
          );
        }),
      ),
      // bottomNavigationBar: BottomBar(),
    );
  }
}

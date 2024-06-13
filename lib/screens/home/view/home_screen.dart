import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:we_slide/we_slide.dart';

import '../../music_player/view/music_screen.dart';
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
        panel: MusicScreen(),
        panelHeader: Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade500, width: 1)),
            color: Color(0xff1d1d1d),
          ),
          child: Center(
            child: Text("hello"),
          ),
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

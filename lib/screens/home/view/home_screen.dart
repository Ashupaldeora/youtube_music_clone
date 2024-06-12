import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import '../provider/home.dart';
import 'components/my_appbar.dart';
import 'components/scroll_detector.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    this.sliverFillRemaining,
  });
  final Widget? sliverFillRemaining;
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollDetector.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
        return CustomScrollView(
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
                child: sliverFillRemaining,
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.grey.withOpacity(0.3),
        height: 70,
        backgroundColor: Color(0xff1d1d1d),
        elevation: 0,
        selectedIndex: Provider.of<HomeProvider>(
          context,
        ).selectedIndexInBottomNav,
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(Icons.fast_forward, color: Colors.white),
              icon: Icon(Icons.fast_forward_outlined, color: Colors.white),
              label: "Sample"),
          NavigationDestination(
              selectedIcon: Icon(Icons.explore, color: Colors.white),
              icon: Icon(Icons.explore_outlined, color: Colors.white),
              label: "Explore"),
          NavigationDestination(
              selectedIcon: Icon(Icons.library_music, color: Colors.white),
              icon: Icon(Icons.library_music_outlined, color: Colors.white),
              label: "Library"),
          NavigationDestination(
              selectedIcon: Icon(Icons.music_note, color: Colors.white),
              icon: Icon(Icons.music_note_outlined, color: Colors.white),
              label: "Upgrade"),
        ],
        onDestinationSelected: (value) =>
            Provider.of<HomeProvider>(context, listen: false)
                .updateSelectedIndexInBottomNav(value),
      ),
    );
  }
}

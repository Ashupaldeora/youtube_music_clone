import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
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
    );
  }
}

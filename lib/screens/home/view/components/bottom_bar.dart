import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff1d1d1d),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      currentIndex: Provider.of<HomeProvider>(context).selectedIndexInBottomNav,
      onTap: (value) => Provider.of<HomeProvider>(context, listen: false)
          .updateSelectedIndexInBottomNav(value),
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.music_note),
          icon: Icon(Icons.music_note_outlined),
          label: 'Samples',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.explore),
          icon: Icon(Icons.explore_outlined),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.library_music),
          icon: Icon(Icons.library_music_outlined),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.upgrade),
          icon: Icon(Icons.upgrade_outlined),
          label: 'Upgrade',
        ),
      ],
    );
  }
}

import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:we_slide/we_slide.dart';
import 'package:youtube_music_clone/utils/gradient_list.dart';

class HomeProvider extends ChangeNotifier {
  Random random = Random();
  int _previousIndex = 0;
  int selectedIndexInBottomNav = 0;

  Map currentGradient = {
    'gradient': LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xff0c0121),
        Color(0xff17082a),
        Color(0xff1a0928),
      ],
    ),
    'blendColor': Color(0xff17082a),
  };
  bool _hasScrolled = false;

  bool get hasScrolled => _hasScrolled;

  void updateScrollStatus(bool hasScrolled) {
    _hasScrolled = hasScrolled;
    notifyListeners();
  }

  updateGradientOnRefresh() {
    int newIndex;
    do {
      newIndex = random.nextInt(gradient.length);
    } while (newIndex == _previousIndex);
    currentGradient = gradient[newIndex];
    _previousIndex = newIndex;
    notifyListeners();
  }

  void updateSelectedIndexInBottomNav(int value) {
    selectedIndexInBottomNav = value;
    notifyListeners();
  }
}

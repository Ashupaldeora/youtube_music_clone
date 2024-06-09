import 'package:flutter/widgets.dart';

class HomeProvider extends ChangeNotifier {
  bool _hasScrolled = false;

  bool get hasScrolled => _hasScrolled;

  void updateScrollStatus(bool hasScrolled) {
    _hasScrolled = hasScrolled;
    notifyListeners();
  }
}

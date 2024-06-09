import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home.dart';

class ScrollDetector extends StatefulWidget {
  final Widget child;

  const ScrollDetector({Key? key, required this.child}) : super(key: key);

  @override
  _ScrollDetectorState createState() => _ScrollDetectorState();

  // Method to retrieve the scroll controller
  static ScrollController of(BuildContext context) {
    final _ScrollDetectorState? result =
        context.findAncestorStateOfType<_ScrollDetectorState>();
    if (result != null) {
      return result._scrollController;
    } else {
      throw Exception(
          'ScrollDetector.of() called without a ScrollDetector ancestor.');
    }
  }
}

class _ScrollDetectorState extends State<ScrollDetector> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollStatus = Provider.of<HomeProvider>(context, listen: false);
    if (_scrollController.offset > 0 && !scrollStatus.hasScrolled) {
      scrollStatus.updateScrollStatus(true);
    } else if (_scrollController.offset <= 0 && scrollStatus.hasScrolled) {
      scrollStatus.updateScrollStatus(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

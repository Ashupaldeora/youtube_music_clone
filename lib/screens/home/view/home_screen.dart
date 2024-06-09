import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
                              : Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.black
                        ])),
                    child: sliverFillRemaining,
                  ),
                ),
              ],
            ),
          );
        })
        // Stack(
        //   children: <Widget>[
        //     // Your original Container with its gradient
        //     SizedBox(
        //       height: 360,
        //       child: Container(
        //         decoration: BoxDecoration(
        //           gradient: LinearGradient(
        //             begin: Alignment.bottomLeft,
        //             end: Alignment.topRight,
        //             colors: [
        //               Color(0xff0F2634),
        //               Color(0xff0E163B),
        //               Color(0xff0E163B),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //
        //     Container(
        //       decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //           colors: [
        //             Colors.transparent,
        //             // Start with transparent color at the top
        //             Colors.black, // End with black color at the bottom
        //             Colors.black, // End with black color at the bottom
        //           ],
        //         ),
        //       ),
        //     ),
        //     Container(
        //       height: double.infinity,
        //       width: double.infinity,
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             SizedBox(
        //               height: 10,
        //             ),
        //             MyCategories(),
        //             SizedBox(
        //               height: 45,
        //             ),
        //             Text(
        //               "START RADIO BASED ON A SONG",
        //               style: Theme.of(context).textTheme.bodySmall,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // )
        );
  }
}

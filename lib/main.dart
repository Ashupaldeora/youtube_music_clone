import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music_clone/screens/home/provider/home.dart';
import 'package:youtube_music_clone/screens/home/view/components/scroll_detector.dart';
import 'package:youtube_music_clone/screens/home/view/components/sliver_remaining_screen.dart';

import 'package:youtube_music_clone/screens/home/view/home_screen.dart';

void main() {
  runApp(const YoutubeMusic());
}

class YoutubeMusic extends StatelessWidget {
  const YoutubeMusic({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make status bar transparent
      statusBarBrightness: Brightness.dark, // Set status bar brightness
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      builder: (context, child) => ScrollDetector(
        child: MaterialApp(
          theme: ThemeData(
              textTheme: TextTheme(
                  displayMedium: TextStyle(
                      fontFamily: "EuclidMedium",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                  bodyLarge: TextStyle(
                      fontFamily: "EuclidMedium",
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white),
                  bodyMedium: TextStyle(
                      fontFamily: "YtSans",
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      letterSpacing: -0.7,
                      color: Colors.white),
                  displaySmall: TextStyle(
                      fontFamily: "EuclidRegular",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                  headlineSmall: TextStyle(
                      fontFamily: "EuclidMedium",
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.white),
                  bodySmall: TextStyle(
                      fontFamily: "EuclidRegular",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey))),
          debugShowCheckedModeBanner: false,
          home: SliverRemainingScreen(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youtube_music_clone/screens/home/models/covers_remixes.dart';

import '../../models/quick_picks.dart';

List<Widget> buildSongPages(BuildContext context, bool isQuickPicks) {
  List<Widget> pages = [];
  for (int i = 0; i < quickPicks.length; i += 4) {
    pages.add(
      Column(
        children: [
          ...List.generate(
            4,
            (index) {
              if (i + index >= quickPicks.length)
                return Container(); // Ensure no out of bounds
              final song = quickPicks[i + index];
              final covers = coversData[i + index];
              return InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 0),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: FadeInImage.assetNetwork(
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  "assets/images/loading-image.gif");
                            },
                            placeholder: 'assets/images/loading-image.gif',
                            image:
                                isQuickPicks ? song.imageUrl : covers.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isQuickPicks ? song.songName : covers.songName,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            SizedBox(height: 3),
                            Text(
                              isQuickPicks
                                  ? song.artistName
                                  : covers.artistName,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  return pages;
}

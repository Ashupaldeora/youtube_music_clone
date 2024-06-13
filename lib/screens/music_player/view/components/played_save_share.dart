import 'package:flutter/material.dart';

class PlayedSaveShare extends StatelessWidget {
  const PlayedSaveShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 38,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 15, right: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Played | 507897",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.playlist_add_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Save",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.share,
                        size: 17,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Share",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 5, right: 15),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.file_download_outlined,
                        // size: 17,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Download",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_music_clone/screens/music_player/provider/music.dart';

import '../../home/models/covers_remixes.dart';
import '../../home/models/quick_picks.dart';
import '../model/song.dart';

class SearchMusic extends StatelessWidget {
  const SearchMusic({super.key});

  @override
  Widget build(BuildContext context) {
    final musicProviderTrue = Provider.of<MusicProvider>(context);
    final musicProviderFalse =
        Provider.of<MusicProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              musicProviderFalse.songs.clear();
              musicProviderFalse.updateLoading(false);
              musicProviderFalse.updateMusicSearchSubmitted(false);

              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Container(
          height: 50,
          child: TextField(
            autofocus: true,
            style: Theme.of(context).textTheme.displaySmall,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 25,
                ),
                fillColor: Color(0xff1d1d1d),
                filled: true,
                hintStyle: Theme.of(context).textTheme.displaySmall,
                hintText: "Search songs,artists,podcasts",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none)),
            onSubmitted: (value) {
              musicProviderFalse.searchSongs(value);
              musicProviderFalse.updateMusicSearchSubmitted(true);
            },
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.mic,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.black,
      body: Consumer<MusicProvider>(
        builder: (context, provider, child) {
          if (!provider.isMusicSearchSubmitted) {
            return Center(
              child: Text("Search For Songs"),
            );
          }
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          // Check if songs are empty
          if (provider.songs.isEmpty && !provider.isLoading) {
            return Center(
              child: Text('No songs found'),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: musicProviderTrue.songs.length,
            itemBuilder: (context, index) {
              Song song = musicProviderTrue.songs[index];
              return ListTile(
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(song.imageUrl)),
                      borderRadius: BorderRadius.circular(3)),
                ),
                title: Text(
                  song.title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                subtitle: Text(
                  song.singer,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () async {
                  // Implement what happens when a song tile is tapped
                  print('Song tapped: ${song.title}');
                  if (!musicProviderTrue.isPlaying) {
                    musicProviderFalse.getTotalDuration();

                    musicProviderFalse.updateApiClickedSongs(song.songUrl,
                        song.title, song.singer, song.imageUrl, song.playCount);
                  } else {
                    musicProviderFalse.updatePlaying();

                    musicProviderFalse.updateApiClickedSongs(song.songUrl,
                        song.title, song.singer, song.imageUrl, song.playCount);
                  }
                  musicProviderFalse.controller.jumpToPage(1);
                  musicProviderFalse.updateMusicSearchSubmitted(false);

                  Navigator.of(context).pop();
                  await Future.delayed(
                    Duration(seconds: 1),
                    () => musicProviderFalse.weController.show(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

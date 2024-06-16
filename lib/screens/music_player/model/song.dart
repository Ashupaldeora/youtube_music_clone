import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// class Song {
//   final String image;
//   final String mediaUrl;
//   final String song;
//   final String singers;
//   final int playCount;
//
//   Song(
//       {required this.image,
//       required this.mediaUrl,
//       required this.song,
//       required this.singers,
//       required this.playCount});
//
//   factory Song.fromJson(Map<String, dynamic> json) {
//     return Song(
//         image: json['image'],
//         mediaUrl: json['media_url'],
//         song: json['song'],
//         singers: json['singers'],
//         playCount: json['play_count']);
//   }
// }
class Song {
  final int playCount;
  final String title;
  final String singer;
  final String songUrl;
  final String imageUrl;

  Song({
    required this.playCount,
    required this.title,
    required this.singer,
    required this.songUrl,
    required this.imageUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    // Extract primary artist name from the artists list
    String primaryArtist = json['artists']['primary'][0]['name'];

    // Extract the highest quality image URL
    String imageUrl = json['image'].last['url'];

    // Extract the highest quality song URL
    String songUrl = json['downloadUrl'].last['url'];

    return Song(
      playCount: json['playCount'],
      title: json['name'],
      singer: primaryArtist,
      songUrl: songUrl,
      imageUrl: imageUrl,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'playCount': playCount,
  //     'title': title,
  //     'singer': singer,
  //     'songUrl': songUrl,
  //     'imageUrl': imageUrl,
  //   };
  // }
}

class PlaylistSong {
  String image;
  String mediaUrl;
  String song;
  String singers;
  String playCount;

  PlaylistSong(
      {required this.image,
      required this.mediaUrl,
      required this.song,
      required this.singers,
      required this.playCount});

  factory PlaylistSong.fromJson(Map<String, dynamic> json) {
    return PlaylistSong(
        image: json['image'],
        mediaUrl: json['media_url'],
        song: json['song'],
        singers: json['singers'],
        playCount: json['play_count']);
  }

  static bool containsObjectWithIdAndName(
      List<PlaylistSong> list, String songName, String singer) {
    return list.any(
        (element) => element.song == songName && element.singers == singer);
  }
}

class SongService {
  final String baseUrl = 'https://saavn.dev/api/search/songs?query=';

  Future<List<Song>> searchSongs(String query) async {
    final encodedQuery = query.replaceAll(' ', ''); // Remove spaces
    final response = await http.get(Uri.parse('$baseUrl$encodedQuery'));

    if (response.statusCode == 200) {
      // List<dynamic> jsonList = json.decode(response.body);
      final jsonData = json.decode(response.body);
      final jsonList = jsonData['data']['results'] as List;
      List<Song> songs = jsonList.map((json) => Song.fromJson(json)).toList();
      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }
}

Future<List<Song>> parsePlaylistJson() async {
  String playListJson =
      await rootBundle.loadString('assets/json/playlist.json');
  final parsed = jsonDecode(playListJson);
  final songList = parsed['songs'] as List<dynamic>;
  return songList.map((json) => Song.fromJson(json)).toList();
}

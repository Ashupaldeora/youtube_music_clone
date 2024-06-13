import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Song {
  final String image;
  final String mediaUrl;
  final String song;
  final String singers;
  final int playCount;

  Song(
      {required this.image,
      required this.mediaUrl,
      required this.song,
      required this.singers,
      required this.playCount});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        image: json['image'],
        mediaUrl: json['media_url'],
        song: json['song'],
        singers: json['singers'],
        playCount: json['play_count']);
  }
}

class SongService {
  final String baseUrl = 'http://192.168.123.182:5100';

  Future<List<Song>> searchSongs(String query) async {
    final encodedQuery = query.replaceAll(' ', ''); // Remove spaces
    final response =
        await http.get(Uri.parse('$baseUrl/song/?query=$encodedQuery'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<Song> songs = jsonList.map((json) => Song.fromJson(json)).toList();
      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }
}

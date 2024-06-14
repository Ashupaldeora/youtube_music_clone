import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:youtube_music_clone/screens/home/models/covers_remixes.dart';
import 'package:youtube_music_clone/screens/home/models/quick_picks.dart';

import '../model/song.dart';

class MusicProvider extends ChangeNotifier {
  final CarouselController controller = CarouselController();
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;
  bool isQuickPicks = true;
  bool isPlayingFromApi = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Duration totalDuration = Duration.zero;
  int currentPlayingMusicIndex = 0;
  bool isFirstTimePlayed = true;
  bool isPlayingFromPlaylist = false;
  int currentIndex = 0;
  Duration currentPosition = Duration.zero;
  final TextEditingController _controller = TextEditingController();
  final SongService _songService = SongService();
  List<Song> songs = [];
  Map apiClickedSongs = {
    'song': "",
    'songName': "",
    'singerName': "",
    'image': "",
    'playCount': 0,
  };
  List<PlaylistSong> playlistSongs = [];
  Color backgroundColor = Color(0xff06232d);
  Color secondaryColor = Color(0xff11103d);
  Color thirdColor = Color(0xff0d2233);

  void playNextPlaylistSong() {
    currentIndex = (currentIndex + 1) % playlistSongs.length;
    updateBackgroundColor(playlistSongs[currentIndex].image);
    controller.animateToPage(currentIndex);
    playMusic(playlistSongs[currentIndex].mediaUrl);
    notifyListeners();
  }

  void updateFirstIndexOfPlaylist(QuickPicksData song, HeardInShorts covers) {
    playlistSongs[0].song = isQuickPicks ? song.songName : covers.songName;
    playlistSongs[0].image = isQuickPicks ? song.imageUrl : covers.imageUrl;
    playlistSongs[0].singers =
        isQuickPicks ? song.artistName : covers.artistName;
    playlistSongs[0].mediaUrl = isQuickPicks ? song.songUrl : covers.songUrl;
    playlistSongs[0].playCount = "509051";
    currentIndex = 0;
    updateBackgroundColor(isQuickPicks ? song.imageUrl : covers.imageUrl);
    controller.animateToPage(0);
    notifyListeners();
  }

  void updateFirstIndexFromApiInPlaylist() {}

  void playWhenCarouselChanged(int index) {
    updateBackgroundColor(playlistSongs[index].image);
    playMusic(playlistSongs[index].mediaUrl);
    currentIndex = index;
    notifyListeners();
  }

  void playPreviousPlaylistSong() {
    currentIndex = (currentIndex - 1) % playlistSongs.length;
    if (currentIndex < 0) {
      currentIndex = playlistSongs.length - 1;
    }
    updateBackgroundColor(playlistSongs[currentIndex].image);
    controller.animateToPage(currentIndex);

    playMusic(playlistSongs[currentIndex].mediaUrl);

    notifyListeners();
  }

  Future<void> updateBackgroundColor(String imageUrl) async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl),
    );

    Color lightVibrant =
        paletteGenerator.lightVibrantColor?.color ?? Colors.white;
    backgroundColor = _darkenColor(lightVibrant, 0.8);
    secondaryColor = _darkenColor(lightVibrant, 0.7);
    thirdColor = _darkenColor(lightVibrant, 0.9);
    notifyListeners();
  }

  Color _darkenColor(Color color, double factor) {
    // Factor should be between 0 and 1
    assert(factor >= 0 && factor <= 1);

    // Darken each channel (R, G, B) of the color
    int red = (color.red * (1 - factor)).round();
    int green = (color.green * (1 - factor)).round();
    int blue = (color.blue * (1 - factor)).round();

    return Color.fromRGBO(red, green, blue, 1);
  }

  Future<void> playMusic(String link) async {
    try {
      await assetsAudioPlayer.open(
        Audio.network(link),
      );
    } catch (t) {
      //mp3 unreachable
      print(t);
    }
    getTotalDuration();
  }

  void updateApiClickedSongs(String song, String songName, String singer,
      String image, int playCount) {
    playlistSongs[0].mediaUrl = song;
    playlistSongs[0].song = songName;
    playlistSongs[0].singers = singer;
    playlistSongs[0].image = image;
    playlistSongs[0].playCount = playCount.toString();
    currentIndex = 0;
    updateBackgroundColor(image);
    controller.animateToPage(0);
    print(apiClickedSongs);

    notifyListeners();
  }

  void updateLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void searchSongs(String query) async {
    _isLoading = true;
    notifyListeners();
    try {
      List<Song> songs = await _songService.searchSongs(query);

      this.songs = songs;
      notifyListeners();
    } catch (e) {
      print('Error searching songs: $e');
      // Handle error
    }
    _isLoading = false;

    notifyListeners();
  }

  void updateCurrentDuration() {
    assetsAudioPlayer.currentPosition.listen((position) {
      currentPosition = position;
      notifyListeners();
    });
  }

  void updateCurrentPlayingIndex(int index, bool isQuickPicks) {
    currentPlayingMusicIndex = index;
    this.isQuickPicks = isQuickPicks;
    print(isQuickPicks.toString() +
        "------------------------------" +
        currentPlayingMusicIndex.toString());
    notifyListeners();
  }

  void updatePlaying() {
    if (assetsAudioPlayer.isPlaying.value) {
      isPlaying = false;
      assetsAudioPlayer.pause();
    } else {
      if (isFirstTimePlayed) {
        playMusic(quickPicks[0].songUrl);
      } else {
        assetsAudioPlayer.play();
      }
      isPlaying = true;
    }
    notifyListeners();
  }

  Future<void> _loadSongs() async {
    String playListJson =
        await rootBundle.loadString('assets/json/playlist.json');
    final parsed = jsonDecode(playListJson);
    final songList = parsed['songs'] as List<dynamic>;
    playlistSongs =
        songList.map((json) => PlaylistSong.fromJson(json)).toList();

    notifyListeners();
  }

  MusicProvider() {
    assetsAudioPlayer.isPlaying.listen((playing) {
      isPlaying = playing;
      notifyListeners();
    });

    _loadSongs();

    updateCurrentDuration();
    assetsAudioPlayer.playerState.listen((playerState) {
      if (playerState == PlayerState.stop) {
        playNextPlaylistSong();
      }
    });
  }
  void getTotalDuration() {
    assetsAudioPlayer.current.listen((playingAudio) {
      if (playingAudio != null) {
        totalDuration = playingAudio.audio.duration;
        print(totalDuration);
      }
    });

    notifyListeners();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

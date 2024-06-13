import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

import '../model/song.dart';

class MusicProvider extends ChangeNotifier {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;
  bool isQuickPicks = true;
  bool isPlayingFromApi = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Duration totalDuration = Duration.zero;
  int currentPlayingMusicIndex = 0;
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

  void updateIsPlayingFromApi(bool isPlaying) {
    isPlayingFromApi = isPlaying;
    notifyListeners();
  }

  void updateApiClickedSongs(String song, String songName, String singer,
      String image, int playCount) {
    print(
        "-----------------------------------------------------------------------");
    apiClickedSongs['song'] = song;
    apiClickedSongs['songName'] = songName;
    apiClickedSongs['singerName'] = singer;
    apiClickedSongs['image'] = image;
    apiClickedSongs['playCount'] = playCount;

    print(apiClickedSongs);
    print(
        "-----------------------------------------------------------------------" +
            isPlayingFromApi.toString());
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
      assetsAudioPlayer.play();

      isPlaying = true;
    }
    notifyListeners();
  }

  MusicProvider() {
    assetsAudioPlayer.isPlaying.listen((playing) {
      isPlaying = playing;
      notifyListeners();
    });
    updateCurrentDuration();
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

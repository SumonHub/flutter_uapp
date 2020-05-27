import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutteruapp/screens/video_list/models/video.dart';
import 'package:flutteruapp/utils/admob_ads.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key key, @required this.video}) : super(key: key);
  final Video video;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer>
    with TickerProviderStateMixin {
  YoutubePlayerController _controller;

  bool isOffline = false;

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isOffline = true;
      });
    } else {
      setState(() {
        isOffline = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print('------------>player initState<---------------');
    Ads.hideBannerAd();
    checkConnection();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.link),
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    print('------------>player dispose<---------------');
    _controller.dispose();
    Ads.initialize();
    Ads.showBannerAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget yt() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: YoutubePlayer(
              width: MediaQuery.of(context).size.width,
              controller: _controller,
              actionsPadding: EdgeInsets.only(left: 16.0),
            ),
          ),
        ),
      );
    }

    if (isOffline) {
      return Scaffold(
        body: Center(
          child: Text('Please turn on internet!'),
        ),
      );
    }

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/home_clean.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          yt(),
        ],
      ),
    );
  }
}

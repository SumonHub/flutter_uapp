import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutteruapp/screens/video_list/models/video.dart';
import 'package:flutteruapp/utils//Ads.dart';
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
    Ads.hideBannerAd();
    checkConnection();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //  AIzaSyBs5SHwVdGxRJcj7VcLHwzhh0DOGuBqEYY

  @override
  Widget build(BuildContext context) {

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.link),
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
      ),
    );

    Widget yt() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Material(
          color: Color(0XFFFFFFFF),
          elevation: 2.0,
          borderRadius: BorderRadius.circular(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 0,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: YoutubePlayer(
                      width: MediaQuery.of(context).size.width,
                      controller: _controller,
                      bufferIndicator: RichText(
                          text: TextSpan(
                              text: ' Awaiting... ',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              )
                          )
                      ),
                      onReady: () {
                        _controller.toggleFullScreenMode();
                      },
                    ),
                  ),
                ),
              ),
            ],
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[yt()],
          )
        ],
      ),
    );
  }
}

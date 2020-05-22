import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutteruapp/utils//Ads.dart';
import 'package:flutteruapp/widgets/appbar_container.dart';
import 'package:flutteruapp/widgets/fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'models/video.dart';

class VideoList extends StatefulWidget {
  VideoList({Key key, @required this.videoList}) : super(key: key);
  final List videoList;

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animController;
  YoutubePlayerController youtubeController;

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
    animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: animController);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    Ads.initialize();
    Ads.showBannerAd();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> adsContainer = new List<Widget>();
    adsContainer.add(new Container(
      height: 50.0,
    ));

    if (isOffline) {
      return Scaffold(
        body: Center(
          child: Text('Please turn on internet!'),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarContainer(
            appBarTitle: 'Here It Is!',
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.videoList.length,
                  itemBuilder: (context, index) {
                    Video video = Video.fromJson(widget.videoList[index]);
                    return _videoCard(video: video);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: ExpandedAnimationFab(
        items: [
          FabItem(
            "Favourite Items",
            Icons.favorite,
            onPress: () {
              animController.reverse();
            },
          ),
        ],
        animation: animation,
        onPress: () {
          if (animController.isCompleted) {
            animController.reverse();
          } else {
            animController.forward();
          }
        },
      ),
      persistentFooterButtons: Ads.isAdsShowing() ? adsContainer : null,
    );
  }

  Widget _videoCard({Video video}) {
    return GestureDetector(
      onTap: () {
        Ads.showInterstitialAd();
        Navigator.of(context)
            .pushNamed("/video_player", arguments: video);
      },
      child: Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        child: Card(
          elevation: 3.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  child: Image.network(
                    'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(
                        video.link)}/0.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Amar sonar bangla ami toamy valobashi. chirodin tomar akash tomar batash amar prane bajay bashi sonar bbangla am i',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


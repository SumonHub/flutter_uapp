import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutteruapp/utils//Ads.dart';
import 'package:flutteruapp/configs/AppString.dart';
import 'package:flutteruapp/widgets/appbar_container.dart';
import 'package:flutteruapp/widgets/color_loader.dart';
import 'package:flutteruapp/widgets/fab.dart';

import 'models/video.dart';
import 'models/youtube_search.dart';
import 'widgets/generation_modal.dart';
import 'widgets/search_modal.dart';
import 'widgets/video_card.dart';

class Videos extends StatefulWidget {
  Videos({Key key, @required this.keyword}) : super(key: key);
  final String keyword;

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> with SingleTickerProviderStateMixin {

  String keyword;
  Animation<double> _animation;
  AnimationController _controller;
  YoutubeSearch _youtubeSearch;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    Ads.initialize();
    Ads.showBannerAd();

    print('--------------Videos init----------------');

    super.initState();
  }


  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SearchBottomModal(),
    );
  }

  void _showGenerationModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GenerationModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    //keyword = widget.keyword;
    keyword = "bangla song";

    _youtubeSearch = YoutubeSearch(
      keyword: keyword,
      key: AppString.key,
      maxResults: '50',
      order: YoutubeSearch.RELEVANCE,
    );

    List<Widget> adsContainer = new List<Widget>();
    adsContainer.add(new Container(
      height: 50.0,
    ));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarContainer(
            appBarTitle: 'Here It Is!',
            children: <Widget>[
              SizedBox(height: 34),
              Expanded(
                child: FutureBuilder(
                  future: _youtubeSearch.getVideos(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Video>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Center(
                          child: ColorLoader(),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        List<Video> songs = snapshot.data;
                        return GridView.builder(
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1.4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            padding: EdgeInsets.only(
                                left: 28, right: 28, bottom: 58),
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              return VideoCard(
                                data: songs[index],
                                onPress: () {
                                  Ads.showInterstitialAd();

                                  Navigator.of(context)
                                      .pushNamed("/video_player", arguments: songs[index].id.videoId);
                                },
                              );
                            });
                    }
                    return null;
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
              _controller.reverse();
            },
          ),
          FabItem(
            "All Type",
            Icons.filter_vintage,
            onPress: () {
              _controller.reverse();
            },
          ),
          FabItem(
            "All Gen",
            Icons.flash_on,
            onPress: () {
              _controller.reverse();
              _showGenerationModal();
            },
          ),
          FabItem(
            "Search",
            Icons.search,
            onPress: () {
              _controller.reverse();
              _showSearchModal();
            },
          ),
        ],
        animation: _animation,
        onPress: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
      ),
      persistentFooterButtons: Ads.isAdsShowing() ? adsContainer : null,
    );
  }
}

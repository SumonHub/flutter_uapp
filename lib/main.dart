import 'package:flutter/material.dart';
import 'package:flutteruapp/res/AppColors.dart';
import 'package:flutteruapp/screens/video_list/video_list.dart';

import 'screens/category_list/category_list.dart';
import 'screens/video_player/video_player.dart';
import 'widgets/fade_page_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'CircularStd',
        textTheme: Theme.of(context).textTheme.apply(displayColor: AppColors.black),
        scaffoldBackgroundColor: AppColors.lightGrey,
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _getRoute,
    );
  }

  Route _getRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return FadeRoute(page: CategoryList());

      case '/video_list':
        return FadeRoute(
            page: VideoList(
          videoList: args,
        ));

      case '/video_player':
        return FadeRoute(page: VideoPlayer(
          video: args,
        ));

      default:
        return null;
    }
  }
}

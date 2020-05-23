import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutteruapp/res/AppString.dart';
import 'package:flutteruapp/utils/admob_ads.dart';
import 'package:flutteruapp/widgets/color_loader.dart';

import 'widgets/widget_category_list.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
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
    Ads.initialize();
    Ads.showBannerAd();
  }

  @override
  void dispose() {
    Ads.hideBannerAd();
    super.dispose();
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
      body: FutureBuilder(
          future: Firestore.instance.document(AppString.FIRESTORE_LINK).get(),
          builder: (context, snapshot) {
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
                //return Center(child: Text(snapshot.data));
                return WidgetCategoryList(categoryList: snapshot.data);
            }
            return null;
          }),
      persistentFooterButtons: Ads.isBannerAdsShowing() ? adsContainer : null,
    );
  }
}

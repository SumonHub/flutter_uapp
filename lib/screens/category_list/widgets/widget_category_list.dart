import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'widget_category_card.dart';

class WidgetCategoryList extends StatelessWidget {
  WidgetCategoryList({@required this.categoryList});

  final categoryList;

  Widget _buildVideoGrid({categories}) {
    return GridView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.44,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        padding: EdgeInsets.all(28.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String categoryTitle = categories[index]['title'];
          List videos = categories[index]['videos'];
          return WidgetCategoryCard(
              title: categoryTitle,
              onPress: () {
                Navigator.of(context)
                    .pushNamed("/video_list", arguments: videos);
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 70),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  "What Content\nare you looking for?",
                  style: TextStyle(
                    fontSize: 30,
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                  child: _buildVideoGrid(
                categories: categoryList['response'] as List,
              ))
            ],
          ),
        ],
      ),
    );
  }
}

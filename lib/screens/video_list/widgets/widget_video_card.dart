import 'package:flutter/material.dart';
import 'package:flutteruapp/screens/video_list/models/video.dart';

String capitalizeFirstChar(String text) {
  if (text == null || text.length <= 1) {
    return text.toUpperCase();
  }

  return text[0].toUpperCase() + text.substring(1);
}

class WidgetVideoCard extends StatelessWidget {
  const WidgetVideoCard({
    Key key,
    @required this.video,
    @required this.onPress,
  }) : super(key: key);

  final Function onPress;
  final Video video;

  Widget _buildCardContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: video.link,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  video.title,
                  style: TextStyle(
                    fontSize: 14,
                    height: 0.7,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {

        return Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildCardContent(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

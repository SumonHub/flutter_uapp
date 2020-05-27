import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteruapp/res/AppColors.dart';

class WidgetCategoryCard extends StatelessWidget {
  const WidgetCategoryCard({
    Key key,
    @required this.title,
    @required this.onPress,
  }) : super(key: key);

  final String title;
  final Function onPress;

  Widget _buildCardContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: EdgeInsets.all(0),
          color: AppColors.primary,
          splashColor: Colors.white10,
          highlightColor: Colors.white10,
          elevation: 0,
          highlightElevation: 2,
          onPressed: onPress,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: _buildCardContent(),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_contents_list_panel.dart';

class HomePage extends StatelessWidget {
  static const String routeName = Navigator.defaultRouteName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ContentsListPanel(
          ContentsType.ARTICLE,
          maxCount: 3,
        ),
        SizedBox(height: 18),
        ContentsListPanel(
          ContentsType.QUESTION,
          maxCount: 3,
        ),
      ],
    );
  }
}

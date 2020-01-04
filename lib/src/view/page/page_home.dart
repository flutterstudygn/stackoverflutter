import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/bloc/home_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_contents_list_limited.dart';

class HomePage extends StatelessWidget {
  static const String routeName = Navigator.defaultRouteName;

  HomePage() {
    HomeBloc.instance.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LimitedContentsListPanel(
          stream: HomeBloc.instance.articleStream.stream,
          type: ContentsType.ARTICLE,
        ),
        SizedBox(height: 18),
        LimitedContentsListPanel(
          stream: HomeBloc.instance.questionStream.stream,
          type: ContentsType.QUESTION,
        ),
      ],
    );
  }
}

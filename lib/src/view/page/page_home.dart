import 'package:stackoverflutter/src/bloc/home_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_contents_list_limited.dart';

import '../global_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage() {
    HomeBloc.instance.load();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      path: '/',
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: LimitedContentsListPanel(
                stream: HomeBloc.instance.articleStream.stream,
                type: ContentsType.ARTICLE,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: LimitedContentsListPanel(
                stream: HomeBloc.instance.questionStream.stream,
                type: ContentsType.QUESTION,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

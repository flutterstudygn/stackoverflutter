import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/article_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';
import 'package:stackoverflutter/src/view/global_layout.dart';

class ContentsListPage<T extends ContentsItem> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      path: _generatePath(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            PanelHeaderView(
              title: _generateTitle(),
            ),
          ],
        ),
      ),
    );
  }

  String _generatePath() {
    switch (T) {
      case ArticleItem:
        return '/articles';
      case QuestionItem:
        return '/questions';
    }
    return null;
  }

  String _generateTitle() {
    switch (T) {
      case ArticleItem:
        return 'Articles';
      case QuestionItem:
        return 'Questions';
    }
    return null;
  }
}

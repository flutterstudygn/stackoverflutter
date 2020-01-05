import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/util/query_builder.dart';
import 'package:stackoverflutter/src/view/component/contents/view_article_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_minimized_contents_list.dart';
import 'package:stackoverflutter/src/view/component/contents/view_question_item.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';

class ContentsListPage extends StatelessWidget {
  static const String routeNameArticles = '/articles';
  static const String routeNameQuestions = '/questions';

  /// 리스트의 각 아이템을 만들 builder 함수.
  ///
  /// 인자는 서버로부터 받아오는 arguments object.
  final Widget Function(ContentsItem) _itemBuilder;
  final String _route;
  final String title;
  final int maxCount;

  ContentsListPage(
    this._route,
    this._itemBuilder, {
    this.title,
    this.maxCount = 30,
  });

  factory ContentsListPage.articles({Map<String, String> queryObject}) =>
      ContentsListPage(
        queryObject == null
            ? routeNameArticles
            : routeNameArticles + QueryBuilder.encode(queryObject),
        ArticleItemView.builder,
        title: 'Articles',
      );

  factory ContentsListPage.questions({Map<String, String> queryObject}) =>
      ContentsListPage(
        queryObject == null
            ? routeNameQuestions
            : routeNameQuestions + QueryBuilder.encode(queryObject),
        QuestionItemView.builder,
        title: 'Questions',
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PanelHeaderView(title: title),
        MinimizedContentsList(
          _itemBuilder,
          title.toLowerCase(),
          maxCount: maxCount,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/util/query_builder.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';

class ContentsListPage extends StatelessWidget {
  static const String routeNameArticles = '/articles';
  static const String routeNameQuestions = '/questions';

  /// 리스트의 각 아이템을 만들 builder 함수.
  ///
  /// 인자는 서버로부터 받아오는 arguments object.
  final Widget Function(Map<String, dynamic>) itemBuilder;
  final String route;
  final String title;

  ContentsListPage(this.route, this.itemBuilder, {this.title});

  factory ContentsListPage.articles({Map<String, String> queryObject}) =>
      ContentsListPage(
        queryObject == null
            ? routeNameArticles
            : routeNameArticles + QueryBuilder.encode(queryObject),
        null, // todo: widget builder for articles
        title: 'Articles',
      );

  factory ContentsListPage.questions({Map<String, String> queryObject}) =>
      ContentsListPage(
        queryObject == null
            ? routeNameQuestions
            : routeNameQuestions + QueryBuilder.encode(queryObject),
        null, // todo: widget builder for questions
        title: 'Questions',
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PanelHeaderView(title: title),
        Column(
          children: <Widget>[
            // todo: some content widgets from itemBuilder.
          ],
        ),
      ],
    );
  }
}

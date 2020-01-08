import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/util/query_builder.dart';
import 'package:stackoverflutter/src/util/web_navigator.dart';
import 'package:stackoverflutter/src/view/component/contents/view_article_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_minimized_contents_list.dart';
import 'package:stackoverflutter/src/view/component/contents/view_question_item.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';
import 'package:stackoverflutter/src/view/page/page_contents_edit.dart';

class ContentsListPage extends StatelessWidget {
  static const String routeNameArticles = '/articles';
  static const String routeNameQuestions = '/questions';

  /// 리스트의 각 아이템을 만들 builder 함수.
  ///
  /// 인자는 서버로부터 받아오는 arguments object.
  final Widget Function(ContentsItem) _itemBuilder;
  final String _route;
  final int maxCount;
  final ContentsType contentsType;

  ContentsListPage(
    this._route,
    this._itemBuilder, {
    this.maxCount = 30,
    this.contentsType,
  });

  factory ContentsListPage.articles({Map<String, String> queryObject}) =>
      ContentsListPage(
        queryObject == null
            ? routeNameArticles
            : routeNameArticles + QueryBuilder.encode(queryObject),
        ArticleItemView.builder,
        contentsType: ContentsType.ARTICLE,
      );

  factory ContentsListPage.questions({Map<String, String> queryObject}) =>
      ContentsListPage(
        queryObject == null
            ? routeNameQuestions
            : routeNameQuestions + QueryBuilder.encode(queryObject),
        QuestionItemView.builder,
        contentsType: ContentsType.QUESTION,
      );

  @override
  Widget build(BuildContext context) {
    String title = '';
    switch (this.contentsType) {
      case ContentsType.ARTICLE:
        title = 'Articles';
        break;
      case ContentsType.QUESTION:
        title = 'Questions';
        break;
    }
    return Column(
      children: <Widget>[
        PanelHeaderView(
          title: title,
          sideWidget: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              switch (this.contentsType) {
                case ContentsType.ARTICLE:
                  WebNavigator.of(context)
                      .pushNamed(ContentsEditPage.routeNameArticle);
                  break;
                case ContentsType.QUESTION:
                  WebNavigator.of(context)
                      .pushNamed(ContentsEditPage.routeNameQuestion);
                  break;
              }
            },
          ),
        ),
        MinimizedContentsList(
          _itemBuilder,
          title.toLowerCase(),
          maxCount: maxCount,
        ),
      ],
    );
  }
}

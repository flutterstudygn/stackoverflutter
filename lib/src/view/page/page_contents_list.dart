import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/util/query_builder.dart';
import 'package:stackoverflutter/src/util/web_navigator.dart';
import 'package:stackoverflutter/src/view/component/contents/view_article_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_minimized_contents_list.dart';
import 'package:stackoverflutter/src/view/component/contents/view_question_item.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';
import 'package:stackoverflutter/src/view/page/page_contents_edit.dart';
import 'package:stackoverflutter/src/view/page/page_not_found.dart';

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
  final Widget separator;

  ContentsListPage(
    this._route,
    this._itemBuilder, {
    this.title = '',
    this.maxCount = 30,
    this.separator = const Divider(
      height: 0,
      thickness: 1,
    ),
  });

  factory ContentsListPage.articles({Map<String, String> queryObject}) =>
      ContentsListPage(
        queryObject == null
            ? routeNameArticles
            : routeNameArticles + QueryBuilder.encode(queryObject),
        ArticleItemView.builder,
        title: 'Articles',
        separator: SizedBox(height: 16),
      );

  factory ContentsListPage.questions({Map<String, String> queryObject}) =>
      ContentsListPage(
          queryObject == null
              ? routeNameQuestions
              : routeNameQuestions + QueryBuilder.encode(queryObject),
          QuestionItemView.builder,
          title: 'Questions');

  @override
  Widget build(BuildContext context) {
    final Set<String> splits = _route.split('?').toSet();
    final String route = splits.first;
    final Map<String, String> query = QueryBuilder.decode(splits.last);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 18, right: 18),
            child: PanelHeaderView(title: title),
          ),
          MinimizedContentsList(
            _itemBuilder,
            title.toLowerCase(),
            maxCount: maxCount,
            separator: separator,
            padding: const EdgeInsets.symmetric(horizontal: 18),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        onPressed: () {
          switch (route) {
            case ContentsListPage.routeNameArticles:
              WebNavigator.of(context).pushNamed(
                ContentsEditPage.routeNameArticle,
                arguments: query,
              );
              break;
            case ContentsListPage.routeNameQuestions:
              WebNavigator.of(context).pushNamed(
                ContentsEditPage.routeNameQuestion,
                arguments: query,
              );
              break;
            default:
              WebNavigator.of(context).pushNamed(NotFoundPage.routeName);
              break;
          }
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

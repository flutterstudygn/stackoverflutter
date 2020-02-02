import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/bloc/home_bloc.dart';
import 'package:stackoverflutter/src/util/web_navigator.dart';
import 'package:stackoverflutter/src/view/component/contents/view_article_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_minimized_contents_list.dart';
import 'package:stackoverflutter/src/view/component/contents/view_question_item.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';
import 'package:stackoverflutter/src/view/page/page_contents_list.dart';

class HomePage extends StatelessWidget {
  static const String routeName = Navigator.defaultRouteName;

  HomePage() {
    HomeBloc.instance.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        PanelHeaderView(
          title: 'Articles',
          sideWidget: _buildShowMore(
            context,
            ContentsListPage.routeNameArticles,
          ),
        ),
        MinimizedContentsList(
          ArticleItemView.builder,
          'articles',
          maxCount: 3,
          separator: null,
        ),
        SizedBox(height: 18),
        PanelHeaderView(
          title: 'Questions',
          sideWidget: _buildShowMore(
            context,
            ContentsListPage.routeNameQuestions,
          ),
        ),
        MinimizedContentsList(
          QuestionItemView.builder,
          'questions',
          maxCount: 3,
        ),
      ],
    );
  }

  Widget _buildShowMore(
    BuildContext context,
    String route, {
    String query = '',
  }) {
    return InkWell(
      onTap: () => WebNavigator.of(context).pushNamed('$route$query'),
      child: Text(
        'more >',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}

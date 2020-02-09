import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_query_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_contents_list.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';
import 'package:stackoverflutter/src/view/page/page_contents_list.dart';

class ContentsListPanel extends StatelessWidget {
  final ContentsType type;
  final ContentsQueryItem query;
  final int maxCount;

  ContentsListPanel(this.type, {this.query, this.maxCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PanelHeaderView(
          title: this.type == ContentsType.ARTICLE
              ? 'Articles'
              : this.type == ContentsType.QUESTION ? 'Questions' : '',
          sideWidget: (maxCount ?? 0) > 0 ? _buildShowMore(context) : null,
        ),
        ContentsListView(
          type,
          query: query,
          maxCount: maxCount,
        ),
      ],
    );
  }

  Widget _buildShowMore(BuildContext context) {
    return InkWell(
      onTap: () {
        String path;
        switch (type) {
          case ContentsType.ARTICLE:
            path = ContentsListPage.routeNameArticles;
            break;
          case ContentsType.QUESTION:
            path = ContentsListPage.routeNameQuestions;
            break;
        }
        if (path?.isNotEmpty == true) {
          String queryStr = query?.queryStr ?? '';
          Navigator.of(context).pushNamed('$path$queryStr');
        }
      },
      child: Text(
        'more >',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}

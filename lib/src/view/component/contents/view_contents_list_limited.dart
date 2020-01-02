import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_query_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_article_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_question_item.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';

class LimitedContentsListPanel<T extends ContentsItem> extends StatelessWidget {
  final Stream<List<ContentsItem>> stream;
  final ContentsType type;
  final ContentsQueryItem query;
  final int maxShowingSize;

  LimitedContentsListPanel({
    @required this.stream,
    @required this.type,
    this.query,
    this.maxShowingSize = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PanelHeaderView(
          title: this.type == ContentsType.ARTICLE
              ? 'Articles'
              : this.type == ContentsType.QUESTION ? 'Questions' : '',
          sideWidget: _buildShowMore(
            context,
            path: this.type == ContentsType.ARTICLE
                ? '/articles'
                : this.type == ContentsType.QUESTION ? '/questions' : '',
          ),
        ),
        _buildItemList(this.type),
      ],
    );
  }

  Widget _buildShowMore(BuildContext context, {String path}) {
    return InkWell(
      onTap: () {
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

  Widget _buildItemList(ContentsType contentsType) {
    return StreamBuilder<List<ContentsItem>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Error',
              style: Theme.of(context).textTheme.subhead,
            ),
          ));
        }
        if (stream == null ||
            (snapshot.connectionState == ConnectionState.active &&
                snapshot.data?.isNotEmpty != true)) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No result',
              style: Theme.of(context).textTheme.subhead,
            ),
          ));
        }

        int length = snapshot.data?.length ?? maxShowingSize;
        if (length > maxShowingSize) length = maxShowingSize;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Column(
            children: List.generate(
              length,
              (idx) {
                ContentsItem item = idx < (snapshot.data?.length ?? 0)
                    ? snapshot.data[idx]
                    : null;
                switch (contentsType) {
                  case ContentsType.ARTICLE:
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ArticleItemView(item),
                    );
                  case ContentsType.QUESTION:
                    return Column(
                      children: <Widget>[
                        QuestionItemView(item),
                        Divider(
                          height: 0,
                          thickness: 1.0,
                        ),
                      ],
                    );
                }
                return Container();
              },
            ),
          ),
        );
      },
    );
  }
}

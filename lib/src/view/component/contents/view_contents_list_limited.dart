import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_article_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_question_item.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';

class LimitedContentsListPanel<T extends ContentsItem> extends StatelessWidget {
  final Stream<List<ContentsItem>> stream;
  final ContentsType type;
  final int maxShowingSize;

  LimitedContentsListPanel({
    @required this.stream,
    @required this.type,
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
          Navigator.of(context).pushNamed(path);
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
      builder: (_, snapshot) {
        if (stream == null) return Container();
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

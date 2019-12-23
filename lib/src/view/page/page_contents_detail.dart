import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/article_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';

import '../global_layout.dart';

class ContentsDetailPage<T extends ContentsItem> extends StatelessWidget {
  final String itemId;

  const ContentsDetailPage({
    this.itemId,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(),
    );
  }

  String _generatePath() {
    switch (T) {
      case ArticleItem:
        return '/articles/$itemId';
      case QuestionItem:
        return '/questions/$itemId';
    }
    return null;
  }
}

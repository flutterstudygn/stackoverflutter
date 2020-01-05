import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';
import 'package:stackoverflutter/src/util/web_navigator.dart';
import 'package:stackoverflutter/src/view/page/page_contents_detail.dart';

class QuestionItemView extends StatelessWidget {
  final QuestionItem _item;

  const QuestionItemView(this._item, {Key key}) : super(key: key);

  static Widget Function(ContentsItem) builder = (item) {
    try {
      return QuestionItemView(QuestionItem.fromContents(item));
    } catch (_) {
      return SizedBox();
    }
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _item?.id == null
          ? null
          : () {
              WebNavigator.of(context).pushNamed(
                '${ContentsDetailPage.routeNameQuestion}?id=${_item.id}',
                arguments: _item,
              );
            },
      child: Container(
        width: double.infinity,
        child: Text(_item.title),
      ),
    );
  }
}

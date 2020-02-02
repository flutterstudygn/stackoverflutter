import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';
import 'package:stackoverflutter/src/util/web_navigator.dart';
import 'package:stackoverflutter/src/view/component/view_dummy.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    (_item?.title?.isNotEmpty == true)
                        ? Text(
                            _item?.title ?? '',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subhead,
                          )
                        : DummyView.height(24),
                    SizedBox(height: 2.0),
                    (_item?.contents?.isNotEmpty == true)
                        ? Text(
                            _item?.contents,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.body1.copyWith(
                                color:
                                    Theme.of(context).textTheme.caption.color),
                          )
                        : DummyView.height(14),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                constraints: BoxConstraints(minHeight: 48.0),
                width: 1.0,
                color: Theme.of(context).dividerColor,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.chat_bubble_outline, color: Colors.grey),
                    SizedBox(width: 3.0),
                    Text(
                      '${_item?.commentCount ?? '-'}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

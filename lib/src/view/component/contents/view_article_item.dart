import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/article_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';

class ArticleItemView extends StatelessWidget {
  final ArticleItem _item;

  const ArticleItemView(this._item, {Key key}) : super(key: key);

  static Widget Function(ContentsItem) builder = (item) {
    try {
      return ArticleItemView(ArticleItem.fromContents(item));
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
              Navigator.of(context).pushNamed(
                '/articles?id=${_item.id}',
                arguments: _item,
              );
            },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Text(_item.title),
      ),
    );
  }
}

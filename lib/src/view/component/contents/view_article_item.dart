import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/article_item.dart';

class ArticleItemView extends StatelessWidget {
  final ArticleItem _item;

  const ArticleItemView(this._item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _item?.id == null
          ? null
          : () {
              Navigator.of(context).pushNamed('/articles?id=${_item.id}');
            },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Container(height: 100.0),
      ),
    );
  }
}

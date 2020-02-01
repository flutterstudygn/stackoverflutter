import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/comments/comment_item.dart';
import 'package:stackoverflutter/src/view/component/view_user_contents_row.dart';

class CommentItemView extends StatelessWidget {
  final CommentItem _commentItem;
  final bool showDivider;
  final OnDeleteItem onDeleteItem;

  CommentItemView(
    this._commentItem, {
    this.showDivider = true,
    this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserContentsView.comment(
            _commentItem,
            onDeleteItem: onDeleteItem,
          ),
          Text(_commentItem.contents ?? ''),
          if (showDivider) Container(width: double.infinity, child: Divider()),
        ],
      ),
    );
  }
}

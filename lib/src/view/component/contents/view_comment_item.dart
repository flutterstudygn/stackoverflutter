import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
    return Column(
      children: <Widget>[
        UserContentsView.comment(
          _commentItem,
          onDeleteItem: onDeleteItem,
        ),
        Markdown(
          data: _commentItem.contents,
          shrinkWrap: true,
        ),
        if (showDivider) Container(width: double.infinity, child: Divider()),
      ],
    );
  }
}

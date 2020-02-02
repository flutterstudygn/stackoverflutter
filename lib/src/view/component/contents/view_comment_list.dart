import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/bloc/comment_list_bloc.dart';
import 'package:stackoverflutter/src/model/comments/comment_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_comment_item.dart';

class CommentListView extends StatelessWidget {
  final CommentListBloc _bloc;
  CommentListView(this._bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CommentItem>>(
      stream: _bloc.commentList,
      builder: (_, snapshot) {
        if (snapshot.data?.isNotEmpty == true) {
          int listSize = snapshot.data?.length ?? 0;
          return Column(
            children: List.generate(
              min(listSize, _bloc.maxShowingCount),
              (idx) {
                return CommentItemView(
                  snapshot.data[idx],
                  onDeleteItem: (item) async {
                    await _bloc.deleteComment(item);
                  },
                );
              },
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('No result'),
          );
        }
      },
    );
  }
}

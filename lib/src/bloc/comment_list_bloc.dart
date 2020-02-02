import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:stackoverflutter/src/apis/contents/contents_api.dart';
import 'package:stackoverflutter/src/model/comments/comment_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';

const int SHOWING_COUNT = 3;

class CommentListBloc {
  int _maxShowingCount;
  int get maxShowingCount => _maxShowingCount ?? SHOWING_COUNT;

  final BehaviorSubject<List<CommentItem>> _commentListStream =
      BehaviorSubject<List<CommentItem>>();
  Stream<List<CommentItem>> get commentList => _commentListStream.stream;
  final StreamController<int> _totalCountStream = StreamController();
  Stream<int> get totalCount => _totalCountStream.stream;

  final ContentsType _contentsType;
  final String _contentsId;
  CommentsOrderBy _orderBy;
  CommentsOrderBy get orderBy => _orderBy ?? CommentsOrderBy.POPULAR;
  final StreamController<CommentsOrderBy> _orderByStreamController =
      StreamController();
  Stream<CommentsOrderBy> get orderByStream => _orderByStreamController.stream;
  set orderBy(CommentsOrderBy value) {
    if (value != null && _orderBy != value) {
      _orderBy = value;
      _orderByStreamController.add(_orderBy);
      _setResults();
    }
  }

  CommentListBloc(this._contentsType, this._contentsId) {
    _loadComments();
  }

  dispose() {
    _orderByStreamController?.close();
    _totalCountStream?.close();
    _commentListStream?.close();
  }

  void _loadComments() {
    ContentsApi.instance.readComments(_contentsType, _contentsId).then((list) {
      _setResults(list);
    });
  }

  Future<CommentItem> writeComment(CommentItem commentItem) {
    return ContentsApi.instance
        .writeComment(commentItem.contentsId, commentItem)
        .then((result) {
      List<CommentItem> list = _commentListStream.value ?? List();
      if (result != null) {
        list.add(result);
      }
      _setResults(list);
      return result;
    });
  }

  Future<bool> deleteComment(CommentItem commentItem) {
    return ContentsApi.instance
        .deleteComment(
            commentItem.contentsType, commentItem.contentsId, commentItem.id)
        .then((result) {
      if (result == true) {
        List<CommentItem> list = _commentListStream.value ?? List();
        list.removeWhere((item) => item.id == commentItem.id);
        _updateStream(list);
      }
      return result;
    });
  }

  void _setResults([List<CommentItem> results]) {
    results = results ?? _commentListStream.value;
    if (results?.isNotEmpty == true) {
      results.sort((c1, c2) {
        switch (orderBy) {
          case CommentsOrderBy.POPULAR:
            return (c1.likeCount ?? 0) == (c2.likeCount ?? 0)
                ? ((c1?.createTime?.isAfter(c2?.createTime ?? DateTime.now()) ==
                        true
                    ? 1
                    : -1))
                : (c2.likeCount ?? 0) - (c1.likeCount ?? 0);
          case CommentsOrderBy.RECENT:
          default:
            return (c1?.createTime
                        ?.isBefore(c2?.createTime ?? DateTime.now()) ==
                    true
                ? 1
                : -1);
        }
      });
    }
    _updateStream(results);
  }

  void _updateStream([List<CommentItem> results]) {
    results = results ?? _commentListStream.value;
    _maxShowingCount = results?.length ?? 0;
    _totalCountStream.add(results?.length ?? 0);
    _commentListStream.add(results ?? []);
  }
}

enum CommentsOrderBy { POPULAR, RECENT }

class CommentsOrderByHelper {
  static String display(CommentsOrderBy orderBy) {
    switch (orderBy) {
      case CommentsOrderBy.POPULAR:
        return '인기 순';
      case CommentsOrderBy.RECENT:
        return '최신 순';
    }
    return '';
  }
}

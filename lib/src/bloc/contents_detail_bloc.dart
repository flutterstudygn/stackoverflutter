import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stackoverflutter/src/apis/contents/contents_api.dart';
import 'package:stackoverflutter/src/apis/user/user_api.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';
import 'package:stackoverflutter/src/model/comments/comment_item.dart';
import 'package:stackoverflutter/src/model/contents/article_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

class ContentsDetailBloc {
  final StreamController<ContentsItem> _itemStream = StreamController();
  Stream<ContentsItem> get item => _itemStream.stream;

  final BehaviorSubject<List<CommentItem>> _commentsStream = BehaviorSubject();
  Stream<List<CommentItem>> get comments => _commentsStream.stream;
  final StreamController<UserItem> _userStream = StreamController();
  Stream<UserItem> get userInfo => _userStream.stream;
  final BehaviorSubject<bool> _isLikeStream = BehaviorSubject();
  Stream<bool> get isLike => _isLikeStream.stream;

  final BuildContext context;
  ContentsType _contentsType;
  String _itemId;
  ContentsDetailBloc(this.context, this._contentsType);
  init(String itemId, final ContentsItem item) {
    _itemId = item?.id ?? itemId;
    if (item != null) {
      _item = item;
      return;
    }
    if (item == null && _itemId?.isNotEmpty == true) {
      switch (_contentsType) {
        case ContentsType.ARTICLE:
          ContentsApi.instance.readArticle(_itemId).then((v) => _item = v);
          break;
        case ContentsType.QUESTION:
          ContentsApi.instance.readQuestion(_itemId).then((v) => _item = v);
          break;
      }
    }
  }

  set _item(ContentsItem value) {
    if (value == null) return;

    if (value is ArticleItem) {
      _contentsType = ContentsType.ARTICLE;
    } else if (value is QuestionItem) {
      _contentsType = ContentsType.QUESTION;
    }
    _itemStream.add(value);

    _addViewCount();
    _loadIsLike(context);
    _loadUserDetail(value.userId);
  }

  dispose() {
    _userStream?.close();
    _isLikeStream?.close();
    _commentsStream?.close();
  }

  void _addViewCount() {
    ContentsApi.instance.addViewCount(_contentsType, _itemId);
  }

  Future<UserItem> _loadUserDetail(String userId) {
    return UserApi.instance.readUserByUid(userId).then((v) {
      _userStream.add(v);
      return v;
    });
  }

  Future<List<CommentItem>> loadComments() {
    int offset = _commentsStream.value?.length ?? 0;
    return ContentsApi.instance
        .readComments(_contentsType, _itemId, offset: offset)
        .then((v) {
      List<CommentItem> result = (_commentsStream.value ?? List())..addAll(v);
      _commentsStream.add(result);
      return result;
    });
  }

  Future<bool> _loadIsLike(BuildContext context) async {
    UserItem user =
        Provider.of<SessionBloc>(context, listen: false).currentUser;
    if (user?.id?.isNotEmpty == true) {
      return ContentsApi.instance
          .readIsLike(_contentsType, _itemId, user.id)
          .then((v) {
        _isLikeStream.add(v);
        return v;
      });
    }
    _isLikeStream.add(false);
    return false;
  }

  Future<bool> toggleLike(BuildContext context) {
    UserItem user =
        Provider.of<SessionBloc>(context, listen: false).currentUser;
    if (user?.id?.isNotEmpty == true) {
      return ContentsApi.instance
          .toggleLikeContents(
              _contentsType, _itemId, user.id, _isLikeStream.value)
          .then((v) {
        _isLikeStream.add(v);
        return v;
      });
    }
    return null;
  }
}

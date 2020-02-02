import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/apis/contents/contents_api.dart';
import 'package:stackoverflutter/src/apis/user/user_api.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';
import 'package:stackoverflutter/src/model/comments/comment_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';
import 'package:stackoverflutter/src/view/component/view_user_profile.dart';

typedef OnDeleteItem = Future Function(dynamic item);

class UserContentsView extends StatelessWidget {
  final ContentsType _contentsType;
  final dynamic _item;
  final String _uid;
  final OnDeleteItem _onDeleteItem;

  UserContentsView._(
    this._contentsType,
    this._item,
    this._onDeleteItem, {
    Key key,
  })  : _uid = (_item is ContentsItem)
            ? _item.userId
            : (_item is CommentItem) ? _item.userId : null,
        super(key: key);

  factory UserContentsView.contents(
    ContentsType contentsType,
    ContentsItem item, {
    OnDeleteItem onDeleteItem,
  }) {
    ValueKey key = item?.id?.isNotEmpty == true ? ValueKey(item.id) : null;
    return UserContentsView._(contentsType, item, onDeleteItem, key: key);
  }
  factory UserContentsView.comment(
    CommentItem item, {
    OnDeleteItem onDeleteItem,
  }) {
    ValueKey key = item?.id?.isNotEmpty == true ? ValueKey(item.id) : null;
    return UserContentsView._(null, item, onDeleteItem, key: key);
  }

  @override
  Widget build(BuildContext context) {
    DateTime createTime;
    if (_contentsType != null) {
      createTime = (_item as ContentsItem)?.createTime;
    } else {
      try {
        createTime = (_item as CommentItem)?.createTime;
      } catch (_) {}
    }
    return FutureBuilder<UserItem>(
      future: UserApi.instance.readUserByUid(_uid),
      builder: (context, snapshot) {
        UserItem user = snapshot.data;
        if (user == null) return Container();
        bool isMyContents = user.userId != null &&
            user.userId ==
                Provider.of<SessionBloc>(context, listen: false)
                    .currentUser
                    ?.userId;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8.0),
                  child: UserProfileView(
                    user,
                    size: 40,
                    border: 1.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.name ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    if (createTime != null)
                      Text(
                        createTime.toString().substring(0, 16),
                        style: TextStyle(fontSize: 10),
                      ),
                  ],
                ),
              ],
            ),
            ChangeNotifierProvider<IsLikeNotifier>(
              create: (BuildContext context) =>
                  IsLikeNotifier(_contentsType, _item)..readIsLike(context),
              child: Consumer<IsLikeNotifier>(
                builder: (ctx, notifier, _) {
                  return Row(
                    children: <Widget>[
                      if (isMyContents && _contentsType != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: InkWell(
                            child: Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                            onTap: () {},
                          ),
                        ),
                      if (_onDeleteItem != null && isMyContents)
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: InkWell(
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              showDialog(
                                context: ctx,
                                builder: (ctx) {
                                  String itemType = '';
                                  if (_contentsType == null) {
                                    itemType = ' comment';
                                  }
                                  switch (_contentsType) {
                                    case ContentsType.ARTICLE:
                                      itemType = ' article';
                                      break;
                                    case ContentsType.QUESTION:
                                      itemType = ' question';
                                      break;
                                  }
                                  return AlertDialog(
                                    content: Text(
                                        'Are you sure to delete this$itemType?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () async {
                                          await _onDeleteItem(_item);
                                          Navigator.of(ctx).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      InkWell(
                        child: Icon(
                          notifier.isLike
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: notifier.isLike ? Colors.red : Colors.grey,
                        ),
                        onTap: () => notifier.toggleLike(ctx),
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '${notifier.likeCount}',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class IsLikeNotifier extends ChangeNotifier {
  final ContentsType _contentsType;
  final dynamic _item;

  IsLikeNotifier(this._contentsType, this._item);

  bool _isLike;
  bool get isLike => _isLike ?? false;
  set isLike(bool value) {
    _isLike = value ?? false;
    notifyListeners();
  }

  int get likeCount {
    try {
      if (_contentsType != null) {
        return (_item as ContentsItem).likeCount ?? 0;
      } else {
        return (_item as CommentItem).likeCount ?? 0;
      }
    } catch (_) {
      return 0;
    }
  }

  readIsLike(BuildContext context) {
    final String currentUid =
        Provider.of<SessionBloc>(context, listen: false).currentUser?.userId;
    if (currentUid?.isNotEmpty == true) {
      if (_contentsType != null) {
        ContentsItem contentsItem = (_item as ContentsItem);
        ContentsApi.instance
            .readIsLike(ContentsType.ARTICLE, contentsItem.id, currentUid)
            .then((v) {
          isLike = v;
        });
      } else {
        try {
          CommentItem commentItem = (_item as CommentItem);
          ContentsApi.instance
              .readIsLikeComment(commentItem.contentsType,
                  commentItem.contentsId, commentItem.id, currentUid)
              .then((v) {
            isLike = v;
          });
        } catch (_) {}
      }
    }
  }

  toggleLike(BuildContext context) {
    final String currentUid =
        Provider.of<SessionBloc>(context, listen: false).currentUser?.userId;
    if (currentUid?.isNotEmpty == true) {
      if (_contentsType != null) {
        ContentsItem contentsItem = (_item as ContentsItem);
        ContentsApi.instance
            .toggleLikeContents(
                _contentsType, contentsItem.id, currentUid, isLike)
            .then((v) {
          if (isLike) {
            (_item as ContentsItem).likeCount =
                ((_item as ContentsItem).likeCount ?? 1) - 1;
          } else {
            (_item as ContentsItem).likeCount =
                ((_item as ContentsItem).likeCount ?? 0) + 1;
          }
          isLike = v;
        });
      } else {
        try {
          CommentItem commentItem = (_item as CommentItem);
          ContentsApi.instance
              .toggleLikeComment(commentItem.contentsType,
                  commentItem.contentsId, commentItem.id, currentUid, isLike)
              .then((v) {
            if (isLike) {
              (_item as CommentItem).likeCount =
                  ((_item as CommentItem).likeCount ?? 1) - 1;
            } else {
              (_item as CommentItem).likeCount =
                  ((_item as CommentItem).likeCount ?? 0) + 1;
            }
            isLike = v;
          });
        } catch (_) {}
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/apis/user/user_api.dart';
import 'package:stackoverflutter/src/model/contents/article_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';
import 'package:stackoverflutter/src/util/web_navigator.dart';
import 'package:stackoverflutter/src/view/page/page_contents_detail.dart';

import '../view_dummy.dart';

class ArticleItemView extends StatelessWidget {
  final ArticleItem _item;

  const ArticleItemView(this._item, {Key key}) : super(key: key);

  static Widget Function(ContentsItem) builder = (item) {
    try {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: ArticleItemView(ArticleItem.fromContents(item)),
      );
    } catch (_) {
      return SizedBox(
        height: 100,
      );
    }
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _item?.id == null
          ? null
          : () {
              WebNavigator.of(context).pushNamed(
                '${ContentsDetailPage.routeNameArticle}?id=${_item.id}',
                arguments: _item,
              );
            },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Theme.of(context).disabledColor,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _item?.title?.isNotEmpty == true
                  ? Text(
                      _item?.title ?? '',
                      style: Theme.of(context).textTheme.headline,
                      maxLines: 2,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: DummyView.height(28),
                    ),
              _item != null
                  ? DefaultTextStyle(
                      style: Theme.of(context).textTheme.caption,
                      child: Row(
                        children: <Widget>[
                          FutureBuilder<UserItem>(
                            future:
                                UserApi.instance.readUserByUid(_item?.userId),
                            builder: (_, snapshot) {
                              if (snapshot.data?.name?.isNotEmpty == true) {
                                return Text('${snapshot.data?.name} | ');
                              }
                              return Container();
                            },
                          ),
                          Text(
                              _item?.createTime?.toString()?.substring(0, 16) ??
                                  ''),
                          if ((_item?.commentCount ?? -1) >= 0)
                            Row(
                              children: <Widget>[
                                Text(' | '),
                                Icon(
                                  Icons.chat_bubble_outline,
                                  size: 14,
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                ),
                                Text(' ${_item?.commentCount ?? 0}')
                              ],
                            ),
                          if ((_item?.viewCount ?? -1) >= 0)
                            Row(
                              children: <Widget>[
                                Text(' | '),
                                Icon(
                                  Icons.remove_red_eye,
                                  size: 14,
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                ),
                                Text(' ${_item?.viewCount ?? 0}')
                              ],
                            ),
                        ],
                      ),
                    )
                  : DummyView.size(140, 16),
              SizedBox(height: 2.0),
              (_item?.contents?.isNotEmpty == true)
                  ? Text(_item?.contents, maxLines: 3)
                  : Column(
                      children: List.generate(
                        2,
                        (idx) => Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: DummyView.height(14),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

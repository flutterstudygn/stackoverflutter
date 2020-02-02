import 'package:intl/intl.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:flutter/material.dart';

class ContentsUserInfoView extends StatelessWidget {
  final ContentsType _contentsType;

  static const double _avatarSize = 100;

  final ContentsItem passedItem;

  const ContentsUserInfoView(
    this._contentsType, {
    this.passedItem,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //passedItem.userId
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                //UserProfileView(_userItem, size: _avatarSize),
                Icon(
                  Icons.account_circle,
                  size: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      passedItem?.userId ?? 'userId404',
                      style: TextStyle(fontSize: 16),
                    ),
                    if (passedItem?.createTime != null)
                      Text(
                        DateFormat('yyyy.MM.dd HH:mm')
                            .format(passedItem?.createTime),
                        style: TextStyle(fontSize: 10),
                      ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                ),
                Text('${passedItem?.likeCount ?? 0}'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

//                    Column(
//                      children: <Widget>[
//                        Text(item?.contents ?? 'll'),
//                        //Text(item.likeCount)
//                      ],
//                    )

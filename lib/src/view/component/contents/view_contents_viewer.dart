import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/contents_detail_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_contents_userInfo.dart';
import 'package:stackoverflutter/src/view/page/page_contents_detail.dart';

class ContentsViewerView extends StatelessWidget {
  final ContentsType _contentsType;
  final String passedItemId;
  final ContentsItem passedItem;

  const ContentsViewerView(
    this._contentsType, {
    this.passedItemId,
    this.passedItem,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
                //제목
                children: <Widget>[
                  Text(
                    passedItem?.title ?? 'title',
                    style: TextStyle(fontSize: 30),
                  ),
                ]),
            Row(children: <Widget>[
              Text('viewCount:',style: TextStyle(fontWeight: FontWeight.bold,)),
              Text(passedItem?.viewCount.toString() ?? 'viewCount'),
              Text('commentCount:',style: TextStyle(fontWeight: FontWeight.bold,)),
              Text(passedItem?.commentCount.toString() ?? 'commentCount'),
            ]),
          ],
        ),
        Divider(
          color: Colors.black,
          height: 50,
        ),
        Row(children: <Widget>[
          Text(passedItem?.contents ?? 'contents404'),
        ]),
      ],
    );
  }
}

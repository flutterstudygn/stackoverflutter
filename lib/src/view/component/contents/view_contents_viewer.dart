import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';

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
              Text('viewCount:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Text(passedItem?.viewCount.toString() ?? 'viewCount'),
              Text('commentCount:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Text(passedItem?.commentCount.toString() ?? 'commentCount'),
            ]),
          ],
        ),
        Divider(
          color: Colors.black,
          height: 50,
        ),
        Markdown(
          data: passedItem?.contents ?? 'contents404',
          shrinkWrap: true,
        ),
      ],
    );
  }
}

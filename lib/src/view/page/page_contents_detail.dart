import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';

class ContentsDetailPage extends StatelessWidget {
  final ContentsType _contentsType;
  final String itemId;

  const ContentsDetailPage(
    this._contentsType, {
    this.itemId,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(),
    );
  }

  String _generatePath() {
    switch (_contentsType) {
      case ContentsType.ARTICLE:
        return '/articles/$itemId';
      case ContentsType.QUESTION:
        return '/questions/$itemId';
    }
    return null;
  }
}

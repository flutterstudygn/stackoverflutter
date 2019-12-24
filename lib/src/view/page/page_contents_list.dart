import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';
import 'package:stackoverflutter/src/view/global_layout.dart';

class ContentsListPage extends StatelessWidget {
  final ContentsType _contentsType;
  ContentsListPage(this._contentsType);

  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      path: _generatePath(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            PanelHeaderView(
              title: _generateTitle(),
            ),
          ],
        ),
      ),
    );
  }

  String _generatePath() {
    switch (_contentsType) {
      case ContentsType.ARTICLE:
        return '/articles';
      case ContentsType.QUESTION:
        return '/questions';
    }
    return null;
  }

  String _generateTitle() {
    switch (_contentsType) {
      case ContentsType.ARTICLE:
        return 'Articles';
      case ContentsType.QUESTION:
        return 'Questions';
    }
    return null;
  }
}

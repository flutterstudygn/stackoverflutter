import 'package:stackoverflutter/src/bloc/home_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';

import '../global_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage() {
    HomeBloc.instance.load();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      path: '/',
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  PanelHeaderView(
                    title: 'Articles',
                    sideWidget: _buildShowMore(
                      context,
                      path: '/articles',
                    ),
                  ),
                  _buildItemList(ContentsType.ARTICLE),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  PanelHeaderView(
                    title: 'Questions',
                    sideWidget: _buildShowMore(
                      context,
                      path: '/questions',
                    ),
                  ),
                  _buildItemList(ContentsType.QUESTION),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowMore(BuildContext context, {String path}) {
    return InkWell(
      onTap: () {
        if (path?.isNotEmpty == true) {
          Navigator.of(context).pushNamed(path);
        }
      },
      child: Text(
        'more >',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  Widget _buildItemList(ContentsType contentsType) {
    Stream<List<ContentsItem>> stream;
    switch (contentsType) {
      case ContentsType.ARTICLE:
        stream = HomeBloc.instance.articleStream.stream;
        break;
      case ContentsType.QUESTION:
        stream = HomeBloc.instance.questionStream.stream;
        break;
    }
    return StreamBuilder<List<ContentsItem>>(
      stream: stream,
      builder: (_, snapshot) {
        if (stream == null) return Container();
        int length = snapshot.data?.length ?? 3;
        if (length > 3) length = 3;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Column(
            children: List.generate(
              length,
              (idx) {
                ContentsItem item = idx < (snapshot.data?.length ?? 0)
                    ? snapshot.data[idx]
                    : null;
                switch (contentsType) {
                  case ContentsType.ARTICLE:
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
//                      child: ArticleItemView(item),
                    );
                  case ContentsType.QUESTION:
                    return Column(
                      children: <Widget>[
//                        QuestionItemView(item),
                        Divider(
                          height: 0,
                          thickness: 1.0,
                        ),
                      ],
                    );
                }
                return Container();
              },
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/contents_detail_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_comment_list_panel.dart';
import 'package:stackoverflutter/src/view/component/contents/view_contents_userInfo.dart';
import 'package:stackoverflutter/src/view/component/contents/view_contents_viewer.dart';

class ContentsDetailPage extends StatefulWidget {
  final ContentsType _contentsType;
  final String passedItemId;
  final ContentsItem passedItem;

  const ContentsDetailPage(
    this._contentsType, {
    this.passedItemId,
    this.passedItem,
    Key key,
  }) : super(key: key);

  static const String routeNameArticle = '/articles/detail';
  static const String routeNameQuestion = '/questions/detail';

  factory ContentsDetailPage.article(String itemId, ContentsItem item) {
    return ContentsDetailPage(ContentsType.ARTICLE,
        passedItemId: itemId, passedItem: item);
  }

  factory ContentsDetailPage.question(String itemId, ContentsItem item) {
    return ContentsDetailPage(ContentsType.QUESTION,
        passedItemId: itemId, passedItem: item);
  }

  @override
  _ContentsDetailPageState createState() => _ContentsDetailPageState();
}

class _ContentsDetailPageState extends State<ContentsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Provider<ContentsDetailBloc>(
      create: (ctx) => ContentsDetailBloc(ctx, widget._contentsType)
        ..init(widget.passedItemId, widget.passedItem),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<ContentsDetailBloc>(
        builder: (_, bloc, __) {
          return StreamBuilder<ContentsItem>(
            stream: bloc.item,
            builder: (_, snapshot) {
              // ContentsItem item =  snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(widget._contentsType == ContentsType.ARTICLE
                        ? 'Article'
                        : widget._contentsType == ContentsType.QUESTION
                            ? 'Questions'
                            : '-'),
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.title,
                    ),

                    ///
                    ContentsUserInfoView(
                      widget._contentsType,
                      passedItem: widget.passedItem,
                    ),

                    Divider(
                      color: Colors.black,
                    ),

////////////////////////////contents//////////////Article or Question 받아와야함
                    ContentsViewerView(
                      widget._contentsType,
                      passedItemId: widget.passedItemId,
                      passedItem: widget.passedItem,
                    ),

                    SizedBox(height: 50),
                    CommentListPanel(widget._contentsType, widget.passedItemId),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

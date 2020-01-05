import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/contents_detail_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

class ContentsDetailPage extends StatelessWidget {
  final ContentsType _contentsType;
  final String passedItemId;
  final ContentsItem passedItem;

  static const String routeNameArticle = '/articles/detail';
  static const String routeNameQuestion = '/questions/detail';

  const ContentsDetailPage(
    this._contentsType, {
    this.passedItemId,
    this.passedItem,
    Key key,
  }) : super(key: key);

  factory ContentsDetailPage.article(String itemId, ContentsItem item) {
    return ContentsDetailPage(ContentsType.ARTICLE,
        passedItemId: itemId, passedItem: item);
  }
  factory ContentsDetailPage.question(String itemId, ContentsItem item) {
    return ContentsDetailPage(ContentsType.QUESTION,
        passedItemId: itemId, passedItem: item);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Provider<ContentsDetailBloc>(
        create: (ctx) => ContentsDetailBloc(ctx, _contentsType)
          ..init(passedItemId, passedItem),
        dispose: (_, bloc) => bloc.dispose(),
        child: Consumer<ContentsDetailBloc>(
          builder: (_, bloc, __) {
            return StreamBuilder<ContentsItem>(
              stream: bloc.item,
              builder: (_, snapshot) {
                ContentsItem item = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StreamBuilder<UserItem>(
                      stream: bloc.userInfo,
                      builder: (_, snapshot) {
                        return Text(snapshot?.data?.toString() ?? '-');
                      },
                    ),
                    Text(item?.toString() ?? '-'),
                    StreamBuilder<bool>(
                      stream: bloc.isLike,
                      builder: (_, snapshot) {
                        return InkWell(
                          onTap: snapshot?.data != null
                              ? () => bloc.toggleLike(context)
                              : null,
                          child: Text('isLike: ${snapshot?.data ?? '-'}'),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

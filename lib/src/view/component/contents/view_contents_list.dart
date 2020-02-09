import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/contents_list_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_query_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_article_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_question_item.dart';

class ContentsListView extends StatelessWidget {
  final ContentsType type;
  final ContentsQueryItem query;
  final int maxCount;

  ContentsListView(this.type, {this.query, this.maxCount});

  @override
  Widget build(BuildContext context) {
    return Provider<ContentsListBloc>(
      create: (_) =>
          ContentsListBloc(type, query: query, maxCount: maxCount)..loadItems(),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<ContentsListBloc>(
        builder: (_, bloc, __) {
          return StreamBuilder<List<ContentsItem>>(
            stream: bloc.listStream,
            builder: (ctx, snapshot) {
              List<ContentsItem> list = snapshot.data;
              if (snapshot.connectionState != ConnectionState.waiting &&
                  list?.isNotEmpty != true) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.error != null
                      ? 'Failed to load data'
                      : 'No result'),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                itemCount: list?.length ?? 0,
                separatorBuilder: (_, __) {
                  if (type == ContentsType.QUESTION) {
                    return Divider(
                      thickness: 1,
                    );
                  }
                  return Container();
                },
                itemBuilder: (_, idx) {
                  switch (type) {
                    case ContentsType.ARTICLE:
                      return ArticleItemView.builder(list[idx]);
                    case ContentsType.QUESTION:
                      return QuestionItemView.builder(list[idx]);
                  }
                  return Container();
                },
              );
            },
          );
        },
      ),
    );
  }
}

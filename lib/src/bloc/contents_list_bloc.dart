import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:stackoverflutter/src/apis/contents/contents_api.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_query_item.dart';

class ContentsListBloc {
  final ContentsType type;
  final ContentsQueryItem query;
  final int maxCount;

  ContentsListBloc(this.type, {this.query, this.maxCount});

  final BehaviorSubject<List<ContentsItem>> _listController = BehaviorSubject();
  Stream<List<ContentsItem>> get listStream => _listController.stream;

  void dispose() {
    _listController?.close();
  }

  Future<List<ContentsItem>> loadItems({bool clear = false}) async {
    if (clear == true) {
      _listController.value?.clear();
    }
    _listController.add((_listController.value ?? [])
      ..addAll(List.generate(maxCount ?? 10, (_) => ContentsItem())));
    await Future.delayed(Duration(seconds: 1));

    int offset = _listController.value?.length ?? 0;
    switch (type) {
      case ContentsType.ARTICLE:
        ContentsApi.instance
            .readArticles(
                count: maxCount ?? 30, offset: offset, userId: query?.uid)
            .then((result) {
          return _setResult(result);
        });
        break;
      case ContentsType.QUESTION:
        await ContentsApi.instance
            .readQuestions(
                count: maxCount ?? 30, offset: offset, userId: query?.uid)
            .then((result) {
          return _setResult(result);
        });
        break;
    }
    return _listController.value;
  }

  List<ContentsItem> _setResult(List<ContentsItem> response) {
    List<ContentsItem> list = _listController?.value ?? [];
    list.addAll(response);
    list.removeWhere((item) => item.id?.isNotEmpty != true);
    _listController.add(list);
    return list;
  }
}

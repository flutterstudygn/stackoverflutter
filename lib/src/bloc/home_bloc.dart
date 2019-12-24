import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:stackoverflutter/src/apis/article/article_api.dart';
import 'package:stackoverflutter/src/apis/question/question_api.dart';
import 'package:stackoverflutter/src/model/contents/article_item.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';

class HomeBloc {
  BehaviorSubject<List<ArticleItem>> articleStream = BehaviorSubject();
  BehaviorSubject<List<QuestionItem>> questionStream = BehaviorSubject();
  List<ArticleItem> get articles => articleStream.value;
  List<QuestionItem> get questions => questionStream.value;

  HomeBloc._();
  static HomeBloc _instance;
  static HomeBloc get instance {
    if (_instance == null) {
      _instance = HomeBloc._();
    }
    return _instance;
  }

  load() {
    _loadRecentArticles();
    _loadRecentQuestions();
  }

  dispose() {
    articleStream?.close();
    questionStream?.close();
  }

  Future<List<ArticleItem>> _loadRecentArticles() {
    return ArticleApi.instance.readArticles(count: 5).then((v) {
      articleStream.sink.add(v);
      return v;
    });
  }

  Future<List<QuestionItem>> _loadRecentQuestions() {
    return QuestionApi.instance.readQuestions(count: 5).then((v) {
      questionStream.sink.add(v);
      return v;
    });
  }
}

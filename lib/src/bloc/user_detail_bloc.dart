import 'dart:async';

import 'package:stackoverflutter/src/apis/contents/contents_api.dart';
import 'package:stackoverflutter/src/apis/user/user_api.dart';
import 'package:stackoverflutter/src/model/contents/article_item.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';
import 'package:stackoverflutter/src/model/user/user_detail_item.dart';

class UserDetailBloc {
  final StreamController<UserDetailItem> _activitiesStream = StreamController();
  final StreamController<List<ArticleItem>> _articleStream = StreamController();
  final StreamController<List<QuestionItem>> _questionStream =
      StreamController();

  Stream<UserDetailItem> get activities => _activitiesStream.stream;
  Stream<List<ArticleItem>> get articles => _articleStream.stream;
  Stream<List<QuestionItem>> get questions => _questionStream.stream;

  String uid;

  init(String uid) {
    this.uid = uid;
    loadUserArticles();
    loadUserQuestions();
    loadUserActivities();
  }

  dispose() {
    _activitiesStream?.close();
    _articleStream?.close();
    _questionStream?.close();
  }

  Future<List<ArticleItem>> loadUserArticles({
    int count = 30,
    int offset = 0,
  }) {
    return ContentsApi.instance
        .readArticlesByUser(uid, count: count, offset: offset)
        .then((v) {
      _articleStream.add(v);
      return v;
    }).catchError((e) {
      _questionStream.addError(e);
      return null;
    });
  }

  Future<List<QuestionItem>> loadUserQuestions({
    int count = 30,
    int offset = 0,
  }) {
    return ContentsApi.instance
        .readQuestionsByUser(uid, count: count, offset: offset)
        .then((v) {
      _questionStream.add(v);
      return v;
    }).catchError((e) {
      _questionStream.addError(e);
      return null;
    });
  }

  Future<UserDetailItem> loadUserActivities() {
    return UserApi.instance.readUserActivities(uid).then((v) {
      _activitiesStream.add(v);
      return v;
    });
  }
}

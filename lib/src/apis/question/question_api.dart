import 'package:firebase/firebase.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';

class QuestionApi {
  QuestionApi._() : super();
  static QuestionApi _instance;
  static QuestionApi get instance {
    if (_instance == null) {
      _instance = QuestionApi._();
    }
    return _instance;
  }

  Future<List<QuestionItem>> readQuestions({
    int count = 30,
    int offset = 0,
  }) async {
    return firestore()
        .collection('questions')
        .orderBy('createTime', 'desc')
        .limit(count)
        .get()
        .then((v) {
      List<QuestionItem> list = List();
      v.docs.forEach((e) {
        var item = QuestionItem.fromJson(e.data());
        list.add(item..id = e.id);
      });
      return list;
    });
  }

  Future<List<QuestionItem>> readQuestionsByUser(
    String userId, {
    int count = 30,
    int offset = 0,
  }) {
    return firestore()
        .collection('questions')
        .where('userId', '==', userId)
        .orderBy('createTime', 'desc')
        .limit(count)
        .get()
        .then((v) {
      List<QuestionItem> list = List();
      v.docs.forEach((e) {
        var item = QuestionItem.fromJson(e.data());
        list.add(item..id = e.id);
      });
      return list;
    });
  }
}

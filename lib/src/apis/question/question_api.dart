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
    return Future.delayed(
      Duration(milliseconds: 1000),
      () => [
        QuestionItem(id: '123'),
        QuestionItem(id: '456'),
        QuestionItem(id: '789'),
        QuestionItem(id: '000'),
      ],
    );
  }

  Future<List<QuestionItem>> readQuestionsByUser(
    String userId, {
    int count = 30,
    int offset = 0,
  }) {
    return null;
  }
}

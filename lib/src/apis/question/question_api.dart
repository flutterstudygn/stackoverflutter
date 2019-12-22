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
    return null;
  }
}

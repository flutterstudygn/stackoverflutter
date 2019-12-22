import 'package:stackoverflutter/src/model/contents/article_item.dart';

class ArticleApi {
  ArticleApi._() : super();
  static ArticleApi _instance;
  static ArticleApi get instance {
    if (_instance == null) {
      _instance = ArticleApi._();
    }
    return _instance;
  }

  Future<List<ArticleItem>> readArticles({
    int count = 30,
    int offset = 0,
  }) {
    return null;
  }
}

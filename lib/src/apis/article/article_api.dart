import 'package:firebase/firebase.dart';
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
  }) async {
    return firestore()
        .collection('articles')
        .orderBy('createTime')
        .limit(count)
        .get()
        .then((v) {
      List<ArticleItem> list = List();
      v.docs.forEach((e) {
        var item = ArticleItem.fromJson(e.data());
        list.add(item..id = e.id);
      });
      return list;
    });
  }

  Future<List<ArticleItem>> readArticlesByUser(
    String userId, {
    int count = 30,
    int offset = 0,
  }) {
    return null;
  }
}

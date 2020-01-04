import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:stackoverflutter/src/model/comments/comment_item.dart';
import 'package:stackoverflutter/src/model/contents/article_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';

class ContentsApi {
  ContentsApi._() : super();
  static ContentsApi _instance;
  static ContentsApi get instance {
    if (_instance == null) {
      _instance = ContentsApi._();
    }
    return _instance;
  }

  String _getCollection(ContentsType type) {
    switch (type) {
      case ContentsType.ARTICLE:
        return 'articles';
      case ContentsType.QUESTION:
        return 'questions';
    }
    return null;
  }

  void addViewCount(ContentsType type, String id) {
    String collection = _getCollection(type);
    if (collection == null || id?.isNotEmpty != true) return null;
//    firestore().collection(collection).doc(id).update()
  }

  /* Articles */
  Future<ArticleItem> readArticle(String id) {
    return firestore().collection('articles').doc(id).get().then((v) {
      ArticleItem item = ArticleItem.fromJson(v.data());
      return item..id = v.id;
    });
  }

  Future<List<ArticleItem>> readArticles(
      {int count = 30, int offset = 0, String userId}) async {
    CollectionReference ref = firestore().collection('articles');
    if (userId?.isNotEmpty == true) {
      ref = ref.where('userId', '==', userId);
    }
    return ref.orderBy('createTime', 'desc').limit(count).get().then((v) {
      List<ArticleItem> list = List();
      v.docs.forEach((e) {
        ArticleItem item = ArticleItem.fromJson(e.data());
        if (item != null) {
          list.add(item..id = e.id);
        }
      });
      return list;
    }).catchError((e) => e);
  }

  Future<List<ArticleItem>> readArticlesByUser(String userId,
      {int count = 30, int offset = 0}) {
    return readArticles(count: count, offset: offset, userId: userId);
  }

  /* Questions */
  Future<QuestionItem> readQuestion(String id) {
    return firestore().collection('questions').doc(id).get().then((v) {
      QuestionItem item = QuestionItem.fromJson(v.data());
      return item..id = v.id;
    });
  }

  Future<List<QuestionItem>> readQuestions(
      {int count = 30, int offset = 0, String userId}) async {
//    return _readContents(ContentsType.QUESTION, count, offset);
    CollectionReference ref = firestore().collection('questions');
    if (userId?.isNotEmpty == true) {
      ref = ref.where('userId', '==', userId);
    }
    return ref.orderBy('createTime', 'desc').limit(count).get().then((v) {
      List<QuestionItem> list = List();
      v.docs.forEach((e) {
        QuestionItem item = QuestionItem.fromJson(e.data());
        if (item != null) {
          list.add(item..id = e.id);
        }
      });
      return list;
    }).catchError((e) => e);
  }

  Future<List<QuestionItem>> readQuestionsByUser(String userId,
      {int count = 30, int offset = 0}) {
    return readQuestions(count: count, offset: offset, userId: userId);
//    return _readContents(ContentsType.QUESTION, count, offset, userId: userId);
  }

  /* Like */
  Future<bool> toggleLikeContents(
    ContentsType type,
    String itemId,
    String userId,
    bool currentState,
  ) async {
    String collection = _getCollection(type);
    if (collection == null ||
        itemId?.isNotEmpty != true ||
        userId?.isNotEmpty != true ||
        currentState == null) return null;

    CollectionReference ref =
        firestore().collection('$collection/$itemId/likes');

    if (currentState == false) {
      return ref.doc(userId).set({'b': true}).then((_) => true);
    } else if (currentState == true) {
      return ref.doc(userId).delete().then((_) => false);
    }
    return null;
  }

  Future<bool> readIsLike(
    ContentsType type,
    String itemId,
    String userId,
  ) async {
    String collection = _getCollection(type);
    if (collection == null) return null;
    CollectionReference ref =
        firestore().collection('$collection/$itemId/likes');
    return ref.doc(userId).get().then((v) {
      return v.exists;
    });
  }

  /* Comments */
  Future<List<CommentItem>> readComments(ContentsType type, String itemId,
      {int offset = 0, int count = 30, String orderBy = 'createTime'}) {
    String collection = _getCollection(type);
    if (collection == null) return null;
    CollectionReference ref =
        firestore().collection('$collection/$itemId/comments');
    if (orderBy == 'createTime') {
      ref = ref.orderBy('createTime', 'asc');
    } else if (orderBy == 'likeCount') {
      ref = ref.orderBy('likeCount', 'desc');
    }

    return ref.limit(count).get().then((v) {
      List<CommentItem> list = List();
      v.docs.forEach((e) {
        list.add(CommentItem.fromJson(e.data())..id = e.id);
      });
      return list;
    }).catchError((e) => e);
  }

  Future<CommentItem> writeComment() {
    return null;
  }

  Future<bool> deleteComment() async {
    return false;
  }
}

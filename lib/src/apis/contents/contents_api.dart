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

  /// addViewCount : ContentsItem view count(조회수) 증가
  /// params :
  ///   - [contentsType] : [ContentsType.ARTICLE], [ContentsType.QUESTION]
  ///   - [contentsId]
  /// return : void
  void addViewCount(ContentsType contentsType, String contentsId) {
    String collection = _getCollection(contentsType);
    if (collection == null || contentsId?.isNotEmpty != true) return null;
//    firestore().collection(collection).doc(id).update()
  }

  /* Articles */
  /// createArticle : article item 생성
  /// params :
  ///   - [item] :
  Future<ArticleItem> createArticle(ArticleItem item) {
    return firestore().collection('articles').add(item.request()).then((v) {
      return item..id = v.id;
    }).catchError((_) => null);
  }

  /// updateArticle : article item 수정
  /// params :
  ///   - [item] :
  Future<ArticleItem> updateArticle(ArticleItem item) {
    return firestore()
        .collection('articles')
        .doc(item.id)
        .update(data: item.request())
        .then((v) {
      return item;
    }).catchError((_) => null);
  }

  /// readArticleById : Article 정보 조회
  /// (See: [ContentsApi.readQuestionById])
  /// params :
  ///   - [articleId] : 조회하고자 하는 articleId
  /// return : [ArticleItem]
  Future<ArticleItem> readArticleById(String articleId) {
    return firestore().collection('articles').doc(articleId).get().then((v) {
      ArticleItem item = ArticleItem.fromJson(v.data());
      return item..id = v.id;
    });
  }

  /// readArticles : ArticleList 조회
  /// (See: [ContentsApi.readQuestions])
  /// params :
  ///   - [count] : 조회 요청 개수 (default: 30)
  ///   - [offset] : offset (default: 0)
  ///   - [userId] : (optional) [ContentsApi.readArticlesByUser]
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

  /// readArticlesByUser : 사용자 별 ArticleList 조회
  /// params :
  ///   - [userId] :
  ///   - [count] : 조회 요청 개수 (default: 30)
  ///   - [offset] : offset (default: 0)
  /// return : [List<ArticleItem>]
  Future<List<ArticleItem>> readArticlesByUser(String userId,
      {int count = 30, int offset = 0}) {
    return readArticles(count: count, offset: offset, userId: userId);
  }

  /* Questions */
  /// createQuestion : question item 생성
  /// params :
  ///   - [item] :
  Future<QuestionItem> createQuestion(QuestionItem item) {
    return firestore().collection('questions').add(item.request()).then((v) {
      return item..id = v.id;
    }).catchError((_) => null);
  }

  /// updateQuestion : question item 수정
  /// params :
  ///   - [item] :
  Future<QuestionItem> updateQuestion(QuestionItem item) {
    return firestore()
        .collection('question')
        .doc(item.id)
        .update(data: item.request())
        .then((v) {
      return item;
    }).catchError((_) => null);
  }

  /// readQuestionById : Question 정보 조회
  /// (See: [ContentsApi.readArticleById])
  /// params :
  ///   - [questionId] : 조회하고자 하는 questionId
  /// return : [QuestionItem]
  Future<QuestionItem> readQuestionById(String questionId) {
    return firestore().collection('questions').doc(questionId).get().then((v) {
      QuestionItem item = QuestionItem.fromJson(v.data());
      return item..id = v.id;
    });
  }

  /// readQuestions : QuestionList 조회
  /// (See: [ContentsApi.readArticles])
  /// params :
  ///   - [count] : 조회 요청 개수 (default: 30)
  ///   - [offset] : offset (default: 0)
  ///   - [userId] : (optional) [ContentsApi.readQuestionsByUser]
  /// return : [List<QuestionItem>]
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

  /// readQuestionsByUser : 사용자 별 QuestionList 조회
  /// params :
  ///   - [userId] :
  ///   - [count] : 조회 요청 개수 (default: 30)
  ///   - [offset] : offset (default: 0)
  /// return : [List<QuestionItem>]
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
      ref.orderBy('createTime', 'asc');
    } else if (orderBy == 'likeCount') {
      ref.orderBy('likeCount', 'desc');
    }

    return ref.limit(count).get().then((v) {
      List<CommentItem> list = List<CommentItem>();
      v.docs.forEach((e) {
        CommentItem item = CommentItem.fromJson(e.data())..id = e.id;
        list.add(item);
      });
      return list;
    }).catchError((e) => Future.error(e));
  }

  Future<CommentItem> writeComment(String itemId, CommentItem commentItem) {
    if (itemId != commentItem?.contentsId)
      Future.error('itemId is different with comment.contentsId');
    String collection = _getCollection(commentItem.contentsType);
    if (collection == null) return null;
    return firestore()
        .collection('$collection/$itemId/comments')
        .add(commentItem.request())
        .then((v) {
      return commentItem..id = v.id;
    }).catchError((e) => e);
  }

  Future<CommentItem> updateComment(String itemId, CommentItem commentItem) {
    if (itemId != commentItem?.contentsId)
      Future.error('itemId is different with comment.contentsId');
    String collection = _getCollection(commentItem.contentsType);
    if (collection == null) return null;
    return firestore()
        .collection('$collection/$itemId/comments')
        .doc(commentItem.id)
        .update(data: commentItem.request())
        .then((v) {
      return commentItem;
    }).catchError((e) => e);
  }

  Future<bool> deleteComment(
    ContentsType type,
    String contentsId,
    String commentId,
  ) async {
    String collection = _getCollection(type);
    if (collection == null) return null;
    return firestore()
        .collection('$collection/$contentsId/comments')
        .doc(commentId)
        .delete()
        .then((_) => true)
        .catchError((_) => false);
  }
}

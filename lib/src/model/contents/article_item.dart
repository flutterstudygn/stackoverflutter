import 'package:stackoverflutter/src/model/contents/contents_item.dart';

class ArticleItem extends ContentsItem {
  ArticleItem({
    String id,
    String userId,
    String title,
    String contents,
    DateTime createTime,
    int viewCount,
    int commentCount,
    int likeCount,
  }) : super(
          id: id,
          userId: userId,
          title: title,
          contents: contents,
          createTime: createTime,
          viewCount: viewCount,
          commentCount: commentCount,
          likeCount: likeCount,
        );

  factory ArticleItem.fromContents(ContentsItem contents) {
    return ArticleItem(
      id: contents?.id,
      userId: contents?.userId,
      title: contents?.title,
      contents: contents?.contents,
      createTime: contents?.createTime,
      viewCount: contents?.viewCount,
      commentCount: contents?.commentCount,
      likeCount: contents?.likeCount,
    );
  }
  factory ArticleItem.fromJson(Map<String, dynamic> json) {
    return ArticleItem.fromContents(ContentsItem.fromJson(json));
  }

  Map<String, dynamic> toJson() => super.toJson();

  ArticleItem clone() {
    return ArticleItem.fromJson(this.toJson());
  }
}

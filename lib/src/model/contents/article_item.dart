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

  factory ArticleItem.fromJson(Map<String, dynamic> json) {
    return ContentsItem.fromJson(json) as ArticleItem;
  }

  Map<String, dynamic> toJson() => super.toJson();

  ArticleItem clone() {
    return ArticleItem.fromJson(this.toJson());
  }
}

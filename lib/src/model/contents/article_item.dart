import 'package:stackoverflutter/src/model/contents/contents_item.dart';

class ArticleItem extends ContentsItem {
  ArticleItem({
    String id,
    String userId,
    String title,
    String contents,
    DateTime createTime,
  }) : super(
          id: id,
          userId: userId,
          title: title,
          contents: contents,
          createTime: createTime,
        );

  factory ArticleItem.fromJson(Map<String, dynamic> json) {
    return ContentsItem.fromJson(json) as ArticleItem;
  }

  Map<String, dynamic> toJson() => super.toJson();

  ArticleItem clone() {
    return ArticleItem.fromJson(this.toJson());
  }
}

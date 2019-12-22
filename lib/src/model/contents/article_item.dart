import 'package:stackoverflutter/src/model/contents/contents_item.dart';

class ArticleItem extends ContentsItem {
  factory ArticleItem.fromJson(Map<String, dynamic> json) {
    return ContentsItem.fromJson(json) as ArticleItem;
  }

  Map<String, dynamic> toJson() => super.toJson();

  ArticleItem clone() {
    return ArticleItem.fromJson(this.toJson());
  }
}

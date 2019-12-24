import 'package:stackoverflutter/src/model/contents/contents_item.dart';

class QuestionItem extends ContentsItem {
  QuestionItem({
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

  factory QuestionItem.fromJson(Map<String, dynamic> json) {
    return ContentsItem.fromJson(json) as QuestionItem;
  }

  Map<String, dynamic> toJson() => super.toJson();

  QuestionItem clone() {
    return QuestionItem.fromJson(this.toJson());
  }
}

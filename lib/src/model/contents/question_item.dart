import 'package:stackoverflutter/src/model/contents/contents_item.dart';

class QuestionItem extends ContentsItem {
  factory QuestionItem.fromJson(Map<String, dynamic> json) {
    return ContentsItem.fromJson(json) as QuestionItem;
  }

  Map<String, dynamic> toJson() => super.toJson();

  QuestionItem clone() {
    return QuestionItem.fromJson(this.toJson());
  }
}

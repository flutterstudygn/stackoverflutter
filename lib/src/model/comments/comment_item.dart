import 'package:json_annotation/json_annotation.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';

part 'comment_item.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentItem {
  String id;
  String userId;
  String contentsId;
  String contents;
  DateTime createTime;
  ContentsType contentsType;

  @JsonKey(ignore: true)
  bool get markdownEnabled => contentsType == ContentsType.QUESTION;

  CommentItem({
    this.id,
    this.userId,
    this.contentsId,
    this.contents,
    this.createTime,
  });

  factory CommentItem.fromJson(Map<String, dynamic> json) =>
      _$CommentItemFromJson(json);

  Map<String, dynamic> toJson() => _$CommentItemToJson(this);

  CommentItem clone() {
    return CommentItem.fromJson(this.toJson());
  }
}

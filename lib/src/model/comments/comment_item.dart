import 'package:firebase/firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';

part 'comment_item.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentItem {
  String id;
  String userId;
  String contentsId;
  String contents;
  @JsonKey(fromJson: parseDateTime, toJson: fromDateTime)
  DateTime createTime;
  @JsonKey(nullable: true)
  ContentsType contentsType;
  @JsonKey(defaultValue: 0)
  int likeCount;

  @JsonKey(ignore: true)
  bool get markdownEnabled => contentsType == ContentsType.QUESTION;

  CommentItem({
    this.id,
    this.userId,
    this.contentsId,
    this.contentsType,
    this.contents,
    this.createTime,
    this.likeCount,
  });

  factory CommentItem.create(String userId, String contentsId,
      ContentsType contentsType, String contents) {
    return CommentItem(
      userId: userId,
      contentsId: contentsId,
      contentsType: contentsType,
      contents: contents,
    );
  }

  factory CommentItem.fromJson(Map<String, dynamic> json) =>
      _$CommentItemFromJson(json);

  Map<String, dynamic> toJson() => _$CommentItemToJson(this);
  Map<String, dynamic> request() => toJson()
    ..remove('id')
    ..removeWhere((k, v) => v == null)
    ..putIfAbsent('createTime', () => FieldValue.serverTimestamp());

  CommentItem clone() {
    return CommentItem.fromJson(this.toJson());
  }

  @override
  String toString() {
    return 'CommentItem{id: $id, userId: $userId, contentsId: $contentsId, contents: $contents, createTime: $createTime, contentsType: $contentsType, likeCount: $likeCount}';
  }
}

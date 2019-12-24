import 'package:json_annotation/json_annotation.dart';

part 'contents_item.g.dart';

enum ContentsType { ARTICLE, QUESTION }

@JsonSerializable()
class ContentsItem {
  String id;
  String userId;
  String title;
  String contents;
  @JsonKey(fromJson: parseDateTime, toJson: fromDateTime)
  DateTime createTime;
  @JsonKey(defaultValue: 0)
  int viewCount;
  @JsonKey(defaultValue: 0)
  int commentCount;
  @JsonKey(defaultValue: 0)
  int likeCount;

  ContentsItem({
    this.id,
    this.userId,
    this.title,
    this.contents,
    this.createTime,
    this.viewCount,
    this.commentCount,
    this.likeCount,
  });

  factory ContentsItem.fromJson(Map<String, dynamic> json) =>
      _$ContentsItemFromJson(json);

  Map<String, dynamic> toJson() => _$ContentsItemToJson(this);

  ContentsItem clone() {
    return ContentsItem.fromJson(this.toJson());
  }

  @override
  String toString() {
    return 'ContentsItem{id: $id, userId: $userId, title: $title, contents: $contents, createTime: $createTime, viewCount: $viewCount, commentCount: $commentCount, likeCount: $likeCount}';
  }
}

fromDateTime(DateTime value) {
  return value;
}

parseDateTime(DateTime value) {
  return value?.toLocal();
}

import 'package:json_annotation/json_annotation.dart';

part 'contents_item.g.dart';

enum ContentsType { ARTICLE, QUESTION }

@JsonSerializable()
class ContentsItem {
  String id;
  String userId;
  String title;
  String contents;
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
}

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

  ContentsItem({
    this.id,
    this.userId,
    this.title,
    this.contents,
    this.createTime,
  });

  factory ContentsItem.fromJson(Map<String, dynamic> json) =>
      _$ContentsItemFromJson(json);

  Map<String, dynamic> toJson() => _$ContentsItemToJson(this);

  ContentsItem clone() {
    return ContentsItem.fromJson(this.toJson());
  }
}

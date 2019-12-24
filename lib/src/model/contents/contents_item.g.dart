// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contents_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentsItem _$ContentsItemFromJson(Map<String, dynamic> json) {
  return ContentsItem(
    id: json['id'] as String,
    userId: json['userId'] as String,
    title: json['title'] as String,
    contents: json['contents'] as String,
    createTime: json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String),
    viewCount: json['viewCount'] as int ?? 0,
    commentCount: json['commentCount'] as int ?? 0,
    likeCount: json['likeCount'] as int ?? 0,
  );
}

Map<String, dynamic> _$ContentsItemToJson(ContentsItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'contents': instance.contents,
      'createTime': instance.createTime?.toIso8601String(),
      'viewCount': instance.viewCount,
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
    };

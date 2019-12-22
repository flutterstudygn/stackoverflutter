// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentItem _$CommentItemFromJson(Map<String, dynamic> json) {
  return CommentItem(
    id: json['id'] as String,
    userId: json['userId'] as String,
    contentsId: json['contentsId'] as String,
    contents: json['contents'] as String,
    createTime: json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String),
  );
}

Map<String, dynamic> _$CommentItemToJson(CommentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'contentsId': instance.contentsId,
      'contents': instance.contents,
      'createTime': instance.createTime?.toIso8601String(),
    };

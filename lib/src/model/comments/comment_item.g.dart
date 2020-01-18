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
    contentsType:
        _$enumDecodeNullable(_$ContentsTypeEnumMap, json['contentsType']),
    contents: json['contents'] as String,
    createTime: parseDateTime(json['createTime'] as DateTime),
    likeCount: json['likeCount'] as int ?? 0,
  );
}

Map<String, dynamic> _$CommentItemToJson(CommentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'contentsId': instance.contentsId,
      'contents': instance.contents,
      'createTime': fromDateTime(instance.createTime),
      'contentsType': _$ContentsTypeEnumMap[instance.contentsType],
      'likeCount': instance.likeCount,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ContentsTypeEnumMap = {
  ContentsType.ARTICLE: 'ARTICLE',
  ContentsType.QUESTION: 'QUESTION',
};

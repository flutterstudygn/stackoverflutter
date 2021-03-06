// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailItem _$UserDetailItemFromJson(Map<String, dynamic> json) {
  return UserDetailItem(
    name: json['name'] as String,
    description: json['description'] as String,
    imageUrl: json['imageUrl'] as String,
    email: json['email'] as String,
    articleCount: json['articleCount'] as int,
    questionCount: json['questionCount'] as int,
    answerCount: json['answerCount'] as int,
    startCount: json['startCount'] as int,
  )..userId = json['userId'] as String;
}

Map<String, dynamic> _$UserDetailItemToJson(UserDetailItem instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'email': instance.email,
      'articleCount': instance.articleCount,
      'questionCount': instance.questionCount,
      'answerCount': instance.answerCount,
      'startCount': instance.startCount,
    };

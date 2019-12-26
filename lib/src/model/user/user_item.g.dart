// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserItem _$UserItemFromJson(Map<String, dynamic> json) {
  return UserItem(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    imageUrl: json['imageUrl'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserItemToJson(UserItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'email': instance.email,
    };

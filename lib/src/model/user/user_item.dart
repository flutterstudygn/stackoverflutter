import 'package:json_annotation/json_annotation.dart';

part 'user_item.g.dart';

@JsonSerializable()
class UserItem {
  String id;
  String name;
  String description;
  String imageUrl;

  UserItem({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) =>
      _$UserItemFromJson(json);

  Map<String, dynamic> toJson() => _$UserItemToJson(this);

  UserItem clone() {
    return UserItem.fromJson(this.toJson());
  }
}

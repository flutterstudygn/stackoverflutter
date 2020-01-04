import 'package:firebase/firebase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_item.g.dart';

@JsonSerializable()
class UserItem {
  String id;
  String name;
  String description;
  String imageUrl;
  String email;

  UserItem({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.email,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) =>
      _$UserItemFromJson(json);
  factory UserItem.firebaseUser(User fbUser) {
    return UserItem(
      id: fbUser?.uid,
      name: fbUser?.displayName,
      email: fbUser?.email,
      imageUrl: fbUser?.photoURL,
    );
  }

  Map<String, dynamic> toJson() => _$UserItemToJson(this);

  UserItem clone() {
    return UserItem.fromJson(this.toJson());
  }

  @override
  String toString() {
    return 'UserItem{id: $id, name: $name, description: $description, imageUrl: $imageUrl, email: $email}';
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

part 'user_detail_item.g.dart';

@JsonSerializable()
class UserDetailItem extends UserItem {
  int articleCount;
  int questionCount;
  int answerCount;
  int startCount;

  UserDetailItem({
    String userId,
    String name,
    String description,
    String imageUrl,
    String email,
    this.articleCount,
    this.questionCount,
    this.answerCount,
    this.startCount,
  }) : super(
          userId: userId,
          name: name,
          description: description,
          imageUrl: imageUrl,
          email: email,
        );

  factory UserDetailItem.fromJson(Map<String, dynamic> json) =>
      _$UserDetailItemFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailItemToJson(this);

  UserDetailItem clone() {
    return UserDetailItem.fromJson(this.toJson());
  }

  static Map<String, int> getActivities(UserDetailItem item) => {
        'Articles': item?.articleCount ?? 0,
        'Questions': item?.questionCount ?? 0,
        'Answers': item?.answerCount ?? 0,
        'Stars': item?.startCount ?? 0,
      };
}

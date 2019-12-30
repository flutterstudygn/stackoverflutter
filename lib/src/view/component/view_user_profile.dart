import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

class UserProfileView extends StatelessWidget {
  final UserItem user;
  final double size;
  final double border;

  UserProfileView(this.user, {this.size = 40, this.border = 1.5});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.size,
      height: this.size,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        child: ClipRRect(
          child: (user?.imageUrl?.isNotEmpty == true)
              ? FadeInImage(
                  image: NetworkImage(user?.imageUrl),
                  placeholder: AssetImage('assets/images/account_circle.png'),
                  fit: BoxFit.cover,
                  width: this.size - (this.border * 2),
                  height: this.size - (this.border * 2),
                )
              : Image.asset('assets/images/account_circle.png'),
          borderRadius: BorderRadius.all(Radius.circular(180.0)),
        ),
      ),
    );
  }
}

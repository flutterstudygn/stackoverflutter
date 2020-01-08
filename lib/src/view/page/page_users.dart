import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/apis/user/user_api.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';
import 'package:stackoverflutter/src/bloc/user_detail_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_query_item.dart';
import 'package:stackoverflutter/src/model/user/user_detail_item.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_contents_list_limited.dart';
import 'package:stackoverflutter/src/view/component/view_user_profile.dart';

const double _activityBarHeight = 50.0;
const double _userCardHeight = 120.0;

class UsersPage extends StatelessWidget {
  static const String routeName = '/users';

  final Future<UserItem> _getUser;

  UsersPage({Map<String, String> query})
      : _getUser = query == null
            ? null
            : Future(() => UserApi.instance.readUserByUid(query['uid']));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserItem>(
      future: _getUser ??
          Future.value(
            Provider.of<SessionBloc>(context).currentUser ??
                Future.error(
                  Exception('Current user doesn\'t exist'),
                ),
          ),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());

        if (snapshot.connectionState == ConnectionState.done) {
          return Provider<UserDetailBloc>(
            create: (_) => UserDetailBloc()..init(snapshot.data.id),
            dispose: (_, bloc) => bloc.dispose(),
            child: Consumer<UserDetailBloc>(
              builder: (ctx, bloc, _) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: _userCardHeight,
                      child: _UsersCard(snapshot.data),
                    ),
                    SizedBox(height: 18),
                    StreamBuilder<UserDetailItem>(
                      stream: bloc.activities,
                      builder: (context, snapshot) {
                        return _UserActivity(snapshot.data);
                      },
                    ),
                    SizedBox(height: 18),
                    LimitedContentsListPanel(
                      stream: bloc.articles,
                      query: ContentsQueryItem(uid: snapshot.data.id),
                      type: ContentsType.ARTICLE,
                    ),
                    SizedBox(height: 18),
                    LimitedContentsListPanel(
                      stream: bloc.questions,
                      query: ContentsQueryItem(uid: snapshot.data.id),
                      type: ContentsType.QUESTION,
                    ),
                  ],
                );
              },
            ),
          );
        }

        return Text('loading');
      },
    );
  }
}

class _UsersCard extends StatelessWidget {
  static const double _avatarSize = 100;
  final UserItem _userItem;

  const _UsersCard(this._userItem, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        UserProfileView(_userItem, size: _avatarSize),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _userItem.name,
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text('EDIT'),
              textColor: Theme.of(context).primaryColor,
              shape: Border.all(color: Theme.of(context).primaryColor),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/users/edit'),
            )
          ],
        )
      ],
    );
  }
}

class _UserActivity extends StatelessWidget {
  final UserDetailItem _userDetailItem;

  _UserActivity(this._userDetailItem);

  @override
  Widget build(BuildContext context) {
    Map<String, int> activities = UserDetailItem.getActivities(_userDetailItem);
    List<Widget> children = List.generate(activities.length, (i) {
      String activity = activities.keys.elementAt(i);
      int count = activities.values.elementAt(i);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              activity,
              style: Theme.of(context).textTheme.subtitle,
            ),
            SizedBox(height: 8),
            Text(
              count?.toString() ?? '-',
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
      );
    });

    for (int i = 1; i < children.length; i += 2) {
      children.insert(
        i,
        Container(
          height: _activityBarHeight,
          child: VerticalDivider(
            color: Colors.grey,
            indent: _activityBarHeight / 8,
            endIndent: _activityBarHeight / 8,
            thickness: 2,
          ),
        ),
      );
    }

    return Row(children: children);
  }
}

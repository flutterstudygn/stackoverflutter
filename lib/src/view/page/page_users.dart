import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/apis/user/user_api.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

import '../global_layout.dart';

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
    return GlobalLayout(
      path: '/users',
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<UserItem>(
          future: _getUser ??
              Future.value(
                Provider.of<SessionBloc>(context).currentUser ??
                    Future.error(
                      Exception('Current user doesn\'t exist'),
                    ),
              ),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());

            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: _userCardHeight,
                    child: _UsersCard(snapshot.data.name),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: _activityBarHeight,
                    child: _UserActivity(),
                  ),
                  SizedBox(height: 16),
                  // todo: user's show articles & questions.
                ],
              );
            }

            return Text('loading');
          },
        ),
      ),
    );
  }
}

class _UsersCard extends StatelessWidget {
  final String _userName;

  const _UsersCard(this._userName, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Icon(
            Icons.person,
            size: 100,
            color: Colors.grey,
          ),
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.grey,
                width: 3,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _userName,
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
  final Map<String, int> _activities = {
    'Articles': 12,
    'Questions': 12,
    'Answers': 12,
    'Stars': 12,
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.generate(_activities.length, (i) {
      String activity = _activities.keys.elementAt(i);
      int count = _activities.values.elementAt(i);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              activity,
              style: Theme.of(context).textTheme.subtitle,
            ),
            SizedBox(height: 8),
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
      );
    });

    for (int i = 1; i < children.length; i += 2) {
      children.insert(
        i,
        VerticalDivider(
          color: Colors.grey,
          indent: _activityBarHeight / 8,
          endIndent: _activityBarHeight / 8,
          thickness: 2,
        ),
      );
    }

    return Row(children: children);
  }
}

import 'package:flutter/material.dart';

import '../global_layout.dart';

const double _activityBarHeight = 50.0;

class UsersPage extends StatelessWidget {
  final List<Widget> contents = [
    _UsersCard(),
    SizedBox(
      height: _activityBarHeight,
      child: _UserActivity(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      path: '/users',
      body: ListView.separated(
        itemCount: contents.length,
        separatorBuilder: (_, __) => SizedBox(height: 16),
        itemBuilder: (_, i) => contents[i],
      ),
    );
  }
}

class _UsersCard extends StatelessWidget {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'User Name',
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
            )
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

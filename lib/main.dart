import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/view/page/page_contents_detail.dart';
import 'package:stackoverflutter/src/view/page/page_contents_list.dart';
import 'package:stackoverflutter/src/view/page/page_not_found.dart';
import 'package:stackoverflutter/src/view/page/page_user_detail.dart';
import 'package:stackoverflutter/src/view/page/page_users.dart';
import 'package:stackoverflutter/src/view/page/page_users_edit.dart';

import './src/view/page/page_home.dart';
import './src/view/page/page_signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionBloc>(
      create: (_) => SessionBloc(),
      child: MaterialApp(
        title: 'stackoverFlutter',
        theme: ThemeData.light(),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return route(HomePage(), settings);
            case '/articles':
              return route(ContentsListPage(ContentsType.ARTICLE), settings);
            case '/questions':
              return route(ContentsListPage(ContentsType.QUESTION), settings);
            case '/users/signin':
              return route(SignInPage(), settings);
            case '/users':
              return route(UsersPage(), settings);
            case '/users/edit':
              return route(UsersEditPage(), settings);
            default:
              if (settings.name.startsWith('/users?id=')) {
                return route(
                  UserDetailPage(settings.arguments),
                  settings,
                );
              }
              if (settings.name.startsWith('/articles?id=')) {
                return route(
                  ContentsDetailPage(ContentsType.ARTICLE, itemId: '1'),
                  settings,
                );
              }
              if (settings.name.startsWith('/questions?id=')) {
                return route(
                  ContentsDetailPage(ContentsType.QUESTION, itemId: '1'),
                  settings,
                );
              }
          }
          return route(NotFoundPage(), settings);
        },
      ),
    );
  }

  PageTransition route(
    Widget child,
    RouteSettings settings, {
    bool maintainState = true,
  }) {
    return PageTransition(
      child: child,
      settings: RouteSettings(
        name: settings.name,
        arguments: settings.arguments,
      ),
      type: PageTransitionType.fade,
    );
  }
}

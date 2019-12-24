import 'package:page_transition/page_transition.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/view/page/page_contents_detail.dart';
import 'package:stackoverflutter/src/view/page/page_contents_list.dart';
import 'package:stackoverflutter/src/view/page/page_not_found.dart';

import './src/view/page/page_home.dart';
import './src/view/page/page_signin.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          default:
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
        isInitialRoute: true,
      ),
      type: PageTransitionType.fade,
    );
  }
}

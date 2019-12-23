import 'package:stackoverflutter/src/model/contents/article_item.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';
import 'package:stackoverflutter/src/view/global_layout.dart';
import 'package:stackoverflutter/src/view/page/page_contents_list.dart';
import 'package:stackoverflutter/src/view/page/page_not_found.dart';

import './src/view/page/page_home.dart';
import './src/view/page/page_signin.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stackoverFlutter',
      theme: ThemeData.light(),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => GlobalLayout(),
        '/articles': (_) => ContentsListPage<ArticleItem>(),
        '/questions': (_) => ContentsListPage<QuestionItem>(),
        SignInPage.routeName: (_) => SignInPage(),
      },
      onGenerateRoute: (settings) {
        return PageTransition(
          child: NotFoundPage(),
          type: PageTransitionType.fade,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stackoverflutter/src/model/contents/article_item.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';
import 'package:stackoverflutter/src/view/global_layout.dart';
import 'package:stackoverflutter/src/view/page/page_contents_list.dart';
import 'package:stackoverflutter/src/view/page/page_not_found.dart';

import './src/view/page/page_home.dart';

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
      },
      onGenerateRoute: (settings) {
        // 주소창에 직접 입력하는 경우 root navigator를 사용하게 되는데
        // GlobalLayout을 사용하지 않는 page를 제외하고는 전부 GlobalLayout의
        // 하위 navigator로 라우팅한다.
        //
        // GlobalLayout을 사용하지 않는 page의 경우 routes 속성에서 정의하여 라우팅.
        return MaterialPageRoute(
          builder: (_) => GlobalLayout(initialRoute: settings.name),
          settings: settings,
        );
      },
      onUnknownRoute: (settings) {
        return PageTransition(
          child: NotFoundPage(),
          type: PageTransitionType.fade,
        );
      },
    );
  }
}

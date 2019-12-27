import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/util/router.dart';
import 'package:stackoverflutter/src/view/global_layout.dart';

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
      home: GlobalLayout(),
      onGenerateRoute: (settings) {
        // 주소창에 직접 입력하는 경우 root navigator를 사용하게 되는데
        // GlobalLayout을 사용하지 않는 page를 제외하고는 전부 GlobalLayout의
        // 하위 navigator로 라우팅한다.
        //
        // GlobalLayout을 사용하지 않는 page의 경우 routes 속성에서 정의하여 라우팅.
        return NoTransitionRoute(
          builder: (_) => GlobalLayout(initialRoute: settings.name),
          settings: settings,
        );
      },
    );
  }
}

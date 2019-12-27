import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/util/query_builder.dart';
import 'package:stackoverflutter/src/util/router.dart';
import 'package:stackoverflutter/src/view/page/page_contents_list.dart';
import 'package:stackoverflutter/src/view/page/page_home.dart';
import 'package:stackoverflutter/src/view/page/page_not_found.dart';
import 'package:stackoverflutter/src/view/page/page_signin.dart';

const double CONTENTS_MIN_WIDTH = 700;
const double CONTENTS_MAX_WIDTH = 800;
const double MENU_MIN_WIDTH = 200;

class GlobalLayout extends StatelessWidget {
  final GlobalKey<NavigatorState> _pageNavigatorKey = GlobalKey();
  final Color backgroundColor;
  final bool showMenu;

  /// Root navigator에 인한 라우팅시(i.e. 주소창에 직접 입력하는 경우) 하위
  /// Navigator에 사용될 route명.
  final String initialRoute;

  GlobalLayout({
    this.initialRoute = Navigator.defaultRouteName,
    this.backgroundColor,
    this.showMenu = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayWidth = MediaQuery.of(context).size.width;
    final displayHeight = MediaQuery.of(context).size.height;

    bool isMobile = displayWidth < CONTENTS_MIN_WIDTH;
    bool hasSideExtra = displayWidth > MENU_MIN_WIDTH * 2 + CONTENTS_MIN_WIDTH;
    final contentsMinWidth =
        displayWidth > CONTENTS_MIN_WIDTH ? CONTENTS_MIN_WIDTH : displayWidth;
    final menuWidth = isMobile
        ? 0
        : hasSideExtra || !showMenu
            ? max(MENU_MIN_WIDTH, (displayWidth - CONTENTS_MAX_WIDTH) / 2)
            : MENU_MIN_WIDTH;

//    final showSignInButton = (path != '/users/signin') || false;

    return Scaffold(
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: InkWell(
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(HomePage.routeName),
          child: Image.asset(
            'assets/images/logo.png',
            width: 120.0,
          ),
        ),
        elevation: 0.25,
        automaticallyImplyLeading: isMobile,
        actions: <Widget>[
//          if (showSignInButton)
          FlatButton(
            onPressed: () => _pageNavigatorKey.currentState
                .pushReplacementNamed(SignInPage.routeName),
            child: Text(
              'Sign In',
            ),
          ),
        ],
      ),
      drawer: showMenu && isMobile
          ? Drawer(
              elevation: 5.0,
              child: _buildMenuLayout(context),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!isMobile)
            showMenu
                ? Container(
                    width: menuWidth,
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      border: Border(right: BorderSide()),
                    ),
                    child: Container(
                      width: MENU_MIN_WIDTH,
                      child: _buildMenuLayout(context),
                    ),
                  )
                : Container(
                    width: menuWidth,
                  ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(18),
              constraints: BoxConstraints(
                minWidth: contentsMinWidth,
                maxWidth: CONTENTS_MIN_WIDTH,
              ),
              child: Navigator(
                key: _pageNavigatorKey,
                initialRoute: initialRoute,
                onGenerateRoute: (settings) {
                  WidgetBuilder builder;

                  Map<String, String> queryObject;

                  if (settings.name.contains('?')) {
                    String query = settings.name.split('?').last;
                    queryObject = QueryBuilder.decode(query);

//                    print(queryObject);
//                    print(QueryBuilder.encode(queryObject));
                  }

                  switch (settings.name) {
                    case HomePage.routeName:
                      builder = (_) => HomePage();
                      break;
                    case SignInPage.routeName:
                      builder = (_) => SignInPage();
                      break;
                    case ContentsListPage.routeNameArticles:
                      builder = (_) => ContentsListPage.articles(
                            queryObject: queryObject,
                          );
                      break;
                    case ContentsListPage.routeNameQuestions:
                      builder = (_) => ContentsListPage.questions(
                            queryObject: queryObject,
                          );
                      break;
                    default:
                      builder = (_) => NotFoundPage();
                      break;
                  }

                  return NoTransitionRoute(
                    builder: builder,
                    settings: settings,
                  );
                },
              ),
            ),
          ),
          if (hasSideExtra)
            Container(
              color: Colors.red,
              width: menuWidth,
              height: displayHeight,
            )
        ],
      ),
    );
  }

  Widget _buildMenuLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildMenuItem(context, 'Home', path: HomePage.routeName),
        _buildMenuItem(context, 'Articles', path: '/articles'),
        _buildMenuItem(context, 'Questions', path: '/questions'),
        _buildMenuItem(context, 'Users', path: '/users'),
        _buildMenuItem(context, 'About', path: '/about'),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String text, {
    String path,
    bool isSelected = false,
  }) {
    return InkWell(
      onTap: () {
        if (path?.isNotEmpty == true) {
          _pageNavigatorKey.currentState.pushReplacementNamed(path);
        }
      },
      child: Container(
        width: double.infinity,
        color: isSelected /*?? this.path.startsWith(path)*/
            ? Color(0xffd0d0d0)
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/home_bloc.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/util/custom_routes.dart';
import 'package:stackoverflutter/src/util/query_builder.dart';
import 'package:stackoverflutter/src/util/web_navigator.dart';
import 'package:stackoverflutter/src/view/page/page_contents_detail.dart';
import 'package:stackoverflutter/src/view/page/page_contents_edit.dart';
import 'package:stackoverflutter/src/view/page/page_contents_list.dart';
import 'package:stackoverflutter/src/view/page/page_home.dart';
import 'package:stackoverflutter/src/view/page/page_not_found.dart';
import 'package:stackoverflutter/src/view/page/page_signin.dart';
import 'package:stackoverflutter/src/view/page/page_users.dart';

import 'component/view_user_profile.dart';

const double CONTENTS_MIN_WIDTH = 700;
const double CONTENTS_MAX_WIDTH = 800;
const double MENU_MIN_WIDTH = 200;

class GlobalLayout extends StatelessWidget {
  final GlobalKey<WebNavigatorState> _navigator = GlobalKey();

  final GlobalKey<_SideMenuState> _sideMenuKey = GlobalKey();

  final String route;

  final Color backgroundColor;

  final bool showMenu;

  GlobalLayout({
    this.route,
    this.backgroundColor,
    this.showMenu = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayWidth = MediaQuery.of(context).size.width;

    bool isMobile = displayWidth < CONTENTS_MIN_WIDTH;
    bool hasSideExtra = displayWidth > MENU_MIN_WIDTH * 2 + CONTENTS_MIN_WIDTH;
    final contentsMinWidth =
        displayWidth > CONTENTS_MIN_WIDTH ? CONTENTS_MIN_WIDTH : displayWidth;
    final menuWidth = isMobile
        ? 0
        : hasSideExtra || !showMenu
            ? max(MENU_MIN_WIDTH, (displayWidth - CONTENTS_MAX_WIDTH) / 2)
            : MENU_MIN_WIDTH;

    var drawerPadding = 0.0;
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        drawerPadding = 24.0;
      }
    } catch (_) {}

    return Scaffold(
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _navigator.currentState.maybePop();
                _sideMenuKey.currentState.currentRoute =
                    _navigator.currentState.backwardRoute;
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _sideMenuKey.currentState.currentRoute =
                    _navigator.currentState.forwardRoute;
                _navigator.currentState.pushForward();
              },
            ),
            InkWell(
              onTap: () =>
                  _navigator.currentState.pushNamed(Navigator.defaultRouteName),
              child: Image.asset(
                'assets/images/logo.png',
                width: 120.0,
              ),
            ),
          ],
        ),
        elevation: 0.25,
        automaticallyImplyLeading: isMobile,
        actions: <Widget>[
          Consumer<SessionBloc>(
            builder: (_, sessionBloc, __) {
              if (sessionBloc.isSignedIn) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: PopupMenuButton(
                    child: UserProfileView(sessionBloc.currentUser),
                    onSelected: (v) async {
                      switch (v) {
                        case 'profile':
                          if (sessionBloc.currentUser?.id != null) {
                            _navigator.currentState.pushNamed(
                              UsersPage.routeName,
                              arguments: sessionBloc.currentUser,
                            );
                          }
                          break;
                        case 'signout':
                          await sessionBloc.signOut();
                          _navigator.currentState.pushNamed('/');
                          break;
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'profile',
                          child: Text('Profile'),
                        ),
                        PopupMenuItem(
                          value: 'signout',
                          child: Text('Sign out'),
                        ),
                      ];
                    },
                  ),
                );
              } else if (route != '/users/signin') {
                return FlatButton(
                  onPressed: () {
                    _navigator.currentState.pushNamed('/users/signin');
                  },
                  child: Text('Sign In'),
                );
              }
              return Container();
            },
          ),
        ],
      ),
      drawer: showMenu && isMobile
          ? Drawer(
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.only(top: drawerPadding),
                child: _SideMenu(
                  _navigator,
                  key: _sideMenuKey,
                ),
              ),
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
                      child: _SideMenu(
                        _navigator,
                        key: _sideMenuKey,
                      ),
                    ),
                  )
                : Container(
                    width: menuWidth,
                  ),
          Expanded(
            child: Container(
              child: WebNavigator(
                key: _navigator,
                initialRoute: route,
                onGenerateRoute: (settings) {
                  Widget page;
                  bool maintainState = true;
                  Map<String, String> queryObject;

                  String routeName = settings.name;
                  if (settings.name.contains('?')) {
                    List<String> splits = settings.name.split('?');
                    routeName = splits.first;
                    String query = splits.last;
                    queryObject = QueryBuilder.decode(query);
                  }

                  switch (routeName) {
                    case HomePage.routeName:
                      page = HomePage();
                      maintainState = false;
                      break;
                    case ContentsListPage.routeNameArticles:
                      page = ContentsListPage.articles(
                        queryObject: queryObject,
                      );
                      maintainState = false;
                      break;
                    case ContentsListPage.routeNameQuestions:
                      page = ContentsListPage.questions(
                        queryObject: queryObject,
                      );
                      maintainState = false;
                      break;
                    case ContentsDetailPage.routeNameArticle:
                      page = ContentsDetailPage.article(
                          queryObject['id'], settings.arguments);
                      break;
                    case ContentsDetailPage.routeNameQuestion:
                      page = ContentsDetailPage.question(
                          queryObject['id'], settings.arguments);
                      break;
                    case ContentsEditPage.routeNameArticle:
                      page = ContentsEditPage.article();
                      break;
                    case ContentsEditPage.routeNameQuestion:
                      page = ContentsEditPage.question();
                      break;
                    case SignInPage.routeName:
                      page = SignInPage();
                      break;
                    case UsersPage.routeName:
                      page = UsersPage(query: queryObject);
                      break;
                    default:
                      page = NotFoundPage();
                      break;
                  }

                  return NoTransitionPageRoute(
                    builder: (_) => page,
                    settings: settings,
                    maintainState: maintainState,
                  );
                },
              ),
            ),
          ),
          if (hasSideExtra)
            Container(width: menuWidth, child: _buildSideExtra())
        ],
      ),
    );
  }

  Widget _buildSideExtra() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Center(
                    child: Text('Ad'),
                  ),
                ),
              ),
            ),
            if (route != '/')
              Column(
                children: <Widget>[
                  _buildRecentItemList(ContentsType.ARTICLE),
                  _buildRecentItemList(ContentsType.QUESTION),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentItemList(ContentsType contentsType) {
    Stream<List<ContentsItem>> stream;
    String title;
    String linkPath;
    switch (contentsType) {
      case ContentsType.ARTICLE:
        stream = HomeBloc.instance.articleStream;
        title = 'Recent articles';
        linkPath = '${ContentsDetailPage.routeNameArticle}?id=';
        break;
      case ContentsType.QUESTION:
        stream = HomeBloc.instance.questionStream;
        title = 'Recent questions';
        linkPath = '${ContentsDetailPage.routeNameQuestion}?id=';
        break;
    }
    return StreamBuilder<List<ContentsItem>>(
      stream: stream,
      builder: (ctx, __) {
        List<ContentsItem> data;
        switch (contentsType) {
          case ContentsType.ARTICLE:
            data = HomeBloc.instance.articles;
            break;
          case ContentsType.QUESTION:
            data = HomeBloc.instance.questions;
            break;
        }
        int length = data?.length ?? 0;
        if (stream == null || length == 0) return Container();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                children: List.generate(
                  length,
                  (idx) {
                    ContentsItem item = data[idx];
                    return Column(
                      children: <Widget>[
                        InkWell(
                          onTap: item?.id == null
                              ? null
                              : () {
                                  _navigator.currentState
                                      .pushNamed('$linkPath${item.id}');
                                },
                          child: Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.title ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 0,
                          thickness: 1.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SideMenu extends StatefulWidget {
  final GlobalKey<WebNavigatorState> _navigator;

  const _SideMenu(this._navigator, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SideMenuState();
}

class _SideMenuState extends State<_SideMenu> {
  String _currentRoute = Navigator.defaultRouteName;

  set currentRoute(String route) {
    if (route == null) return;
    setState(() => _currentRoute = route);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildMenuItem(
          context,
          'Home',
          HomePage.routeName,
        ),
        _buildMenuItem(
          context,
          'Articles',
          ContentsListPage.routeNameArticles,
        ),
        _buildMenuItem(
          context,
          'Questions',
          ContentsListPage.routeNameQuestions,
        ),
        _buildMenuItem(
          context,
          'About',
          '/about',
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String text,
    String path,
  ) {
    return InkWell(
      onTap: () {
        widget._navigator.currentState.pushNamed(path);
        setState(() => _currentRoute = path);
      },
      child: Container(
        width: double.infinity,
        color: _currentRoute == path
            ? Theme.of(context).dividerColor
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

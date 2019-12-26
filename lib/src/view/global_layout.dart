import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/home_bloc.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';

const double CONTENTS_MIN_WIDTH = 700;
const double CONTENTS_MAX_WIDTH = 800;
const double MENU_MIN_WIDTH = 200;

class GlobalLayout extends StatelessWidget {
  final Widget body;
  final String path;
  final Color backgroundColor;
  final bool showMenu;

  const GlobalLayout({
    this.body,
    this.path,
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

    final showSignInButton = (path != '/users/signin');
    bool isSignedIn =
        Provider.of<SessionBloc>(context, listen: false).currentUser != null;

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
        title: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
          child: Image.asset(
            'assets/images/logo.png',
            width: 120.0,
          ),
        ),
        elevation: 0.25,
        automaticallyImplyLeading: isMobile,
        actions: <Widget>[
          if (showSignInButton)
            FlatButton(
              onPressed: () {
                if (isSignedIn) {
                  Provider.of<SessionBloc>(context).signOut();
                } else {
                  Navigator.of(context).pushNamed('/users/signin');
                }
              },
              child: Text(
                isSignedIn ? 'Sign Out' : 'Sign In',
              ),
            )
        ],
      ),
      drawer: showMenu && isMobile
          ? Drawer(
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.only(top: drawerPadding),
                child: _buildMenuLayout(context),
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
                      child: _buildMenuLayout(context),
                    ),
                  )
                : Container(
                    width: menuWidth,
                  ),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                minWidth: contentsMinWidth,
                maxWidth: CONTENTS_MIN_WIDTH,
              ),
              child: body,
            ),
          ),
          if (hasSideExtra)
            Container(width: menuWidth, child: _buildSideExtra())
        ],
      ),
    );
  }

  Widget _buildMenuLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildMenuItem(context, 'Home', path: '/', isSelected: path == '/'),
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
    bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        if (path?.isNotEmpty == true) {
          Navigator.of(context).pushNamed(path);
        }
      },
      child: Container(
        width: double.infinity,
        color: isSelected ?? this.path?.startsWith(path) == true
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
            if (path != '/')
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
        linkPath = '/articles?id=';
        break;
      case ContentsType.QUESTION:
        stream = HomeBloc.instance.questionStream;
        title = 'Recent questions';
        linkPath = '/questions?id=';
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
                                  Navigator.of(ctx)
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

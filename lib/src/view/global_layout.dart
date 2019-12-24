import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

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

    final showSignInButton = (path != '/users/signin') || false;

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
                Navigator.of(context).pushNamed('/users/signin');
              },
              child: Text(
                'Sign In',
              ),
            ),
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

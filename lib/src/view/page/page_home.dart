import 'package:stackoverflutter/src/view/component/view_panel_header.dart';

import '../global_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      path: '/',
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  PanelHeaderView(
                    title: 'Articles',
                    sideWidget: _buildShowMore(
                      context,
                      path: '/questions',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  PanelHeaderView(
                    title: 'Questions',
                    sideWidget: _buildShowMore(
                      context,
                      path: '/questions',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowMore(BuildContext context, {String path}) {
    return InkWell(
      onTap: () {
        if (path?.isNotEmpty == true) {
          Navigator.of(context).pushNamed(path);
        }
      },
      child: Text(
        'more >',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}

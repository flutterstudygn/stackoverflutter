import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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

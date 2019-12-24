import 'package:flutter/material.dart';

class PanelHeaderView extends StatelessWidget {
  final String title;
  final Widget sideWidget;

  const PanelHeaderView({
    this.title,
    this.sideWidget,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                title ?? '',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            sideWidget ?? Container(),
          ],
        ),
        SizedBox(height: 8.0),
        Divider(
          thickness: 3.0,
          height: 0.0,
          color: Theme.of(context).textTheme.title.color,
        ),
      ],
    );
  }
}

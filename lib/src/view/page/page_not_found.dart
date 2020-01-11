import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  static const String routeName = '/page_not_found';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '404\nNot Found',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }
}

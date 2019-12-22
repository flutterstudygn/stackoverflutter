import 'package:flutter/material.dart';

import '../global_layout.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      path: '/404',
      body: Center(
        child: Text(
          '404\nNot Found',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    );
  }
}
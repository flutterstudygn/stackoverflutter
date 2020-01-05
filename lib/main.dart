import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';
import 'package:stackoverflutter/src/view/global_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionBloc>(
      create: (_) => SessionBloc(),
      child: MaterialApp(
        title: 'stackoverFlutter',
        theme: ThemeData.light(),
        initialRoute: Navigator.defaultRouteName,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (_) => GlobalLayout(route: settings.name),
          settings: settings,
        ),
      ),
    );
  }
}

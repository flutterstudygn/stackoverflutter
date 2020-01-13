import 'dart:collection';

import 'package:flutter/widgets.dart';

class WebNavigator extends Navigator {
  const WebNavigator({
    Key key,
    String initialRoute,
    @required RouteFactory onGenerateRoute,
    RouteFactory onUnknownRoute,
    List<NavigatorObserver> observers = const [],
  }) : super(
          key: key,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
          onUnknownRoute: onUnknownRoute,
          observers: observers,
        );

  @optionalTypeArgs
  static Future<T> pushNamed<T extends Object>(
    BuildContext context,
    String routeName, {
    Object arguments,
  }) {
    return WebNavigator.of(context)
        .pushNamed<T>(routeName, arguments: arguments);
  }

  @optionalTypeArgs
  static Future<T> pushReplacementNamed<T extends Object, TO extends Object>(
    BuildContext context,
    String routeName, {
    TO result,
    Object arguments,
  }) {
    return WebNavigator.of(context).pushReplacementNamed<T, TO>(routeName,
        arguments: arguments, result: result);
  }

  @optionalTypeArgs
  static Future<T> popAndPushNamed<T extends Object, TO extends Object>(
    BuildContext context,
    String routeName, {
    TO result,
    Object arguments,
  }) {
    return WebNavigator.of(context).popAndPushNamed<T, TO>(routeName,
        arguments: arguments, result: result);
  }

  @optionalTypeArgs
  static Future<T> pushNamedAndRemoveUntil<T extends Object>(
    BuildContext context,
    String newRouteName,
    RoutePredicate predicate, {
    Object arguments,
  }) {
    return WebNavigator.of(context).pushNamedAndRemoveUntil<T>(
        newRouteName, predicate,
        arguments: arguments);
  }

  @optionalTypeArgs
  static Future<T> push<T extends Object>(
      BuildContext context, Route<T> route) {
    return WebNavigator.of(context).push(route);
  }

  @optionalTypeArgs
  static Future<T> pushReplacement<T extends Object, TO extends Object>(
      BuildContext context, Route<T> newRoute,
      {TO result}) {
    return WebNavigator.of(context)
        .pushReplacement<T, TO>(newRoute, result: result);
  }

  @optionalTypeArgs
  static Future<T> pushAndRemoveUntil<T extends Object>(
      BuildContext context, Route<T> newRoute, RoutePredicate predicate) {
    return WebNavigator.of(context).pushAndRemoveUntil<T>(newRoute, predicate);
  }

  @optionalTypeArgs
  static Future<T> pushForward<T extends Object>(
      BuildContext context, RouteFactory routeFactory) {
    return WebNavigator.of(context).pushForward();
  }

  @optionalTypeArgs
  static void replace<T extends Object>(BuildContext context,
      {@required Route<dynamic> oldRoute, @required Route<T> newRoute}) {
    return WebNavigator.of(context)
        .replace<T>(oldRoute: oldRoute, newRoute: newRoute);
  }

  @optionalTypeArgs
  static void replaceRouteBelow<T extends Object>(BuildContext context,
      {@required Route<dynamic> anchorRoute, Route<T> newRoute}) {
    return Navigator.of(context)
        .replaceRouteBelow<T>(anchorRoute: anchorRoute, newRoute: newRoute);
  }

  static bool canPop(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context, nullOk: true);
    return WebNavigator != null && navigator.canPop();
  }

  @optionalTypeArgs
  static Future<bool> maybePop<T extends Object>(BuildContext context,
      [T result]) {
    return WebNavigator.of(context).maybePop<T>(result);
  }

  @optionalTypeArgs
  static bool pop<T extends Object>(BuildContext context, [T result]) {
    return WebNavigator.of(context).pop<T>(result);
  }

  static void popUntil(BuildContext context, RoutePredicate predicate) {
    WebNavigator.of(context).popUntil(predicate);
  }

  static void removeRoute(BuildContext context, Route<dynamic> route) {
    return WebNavigator.of(context).removeRoute(route);
  }

  static void removeRouteBelow(
      BuildContext context, Route<dynamic> anchorRoute) {
    return WebNavigator.of(context).removeRouteBelow(anchorRoute);
  }

  static WebNavigatorState of(
    BuildContext context, {
    bool rootNavigator = false,
    bool nullOk = false,
  }) {
    final WebNavigatorState navigator = rootNavigator
        ? context.findRootAncestorStateOfType<WebNavigatorState>()
        : context.findAncestorStateOfType<WebNavigatorState>();
    assert(() {
      if (navigator == null && !nullOk) {
        throw FlutterError(
            'WebNavigator operation requested with a context that does not include a WebNavigator.\n'
            'The context used to push or pop routes from the WebNavigator must be that of a '
            'widget that is a descendant of a WebNavigator widget.');
      }
      return true;
    }());
    return navigator;
  }

  @override
  WebNavigatorState createState() => WebNavigatorState();
}

class WebNavigatorState extends NavigatorState {
  final Queue<RouteSettings> _backwardSettingsStack = Queue();

  final Queue<RouteSettings> _forwardRouteSettingsStack = Queue();

  String get backwardRoute {
    if (_backwardSettingsStack.length == 1) return null;
    return _backwardSettingsStack
        .elementAt(_backwardSettingsStack.length - 2)
        .name;
  }

  String get forwardRoute {
    if (_forwardRouteSettingsStack.isEmpty) return null;
    return _forwardRouteSettingsStack.last.name;
  }

  @override
  Future<T> push<T extends Object>(
    Route<T> route, {
    bool forwardPushing = false,
  }) {
    if (!forwardPushing) _forwardRouteSettingsStack.clear();

    if (_backwardSettingsStack.isNotEmpty) {
      if (_backwardSettingsStack.last.name == route.settings.name) return null;
    }

    _backwardSettingsStack.addLast(route.settings);
    return super.push(route);
  }

  @override
  bool pop<T>([T result]) {
    _forwardRouteSettingsStack.addLast(_backwardSettingsStack.removeLast());
    return super.pop(result);
  }

  Future<T> pushForward<T extends Object>() {
    if (_forwardRouteSettingsStack.isEmpty || widget.onGenerateRoute == null) {
      return null;
    }

    Route route;

    try {
      route = widget.onGenerateRoute(_forwardRouteSettingsStack.removeLast());
    } on FlutterError {
      if (widget.onUnknownRoute != null) {
        route = widget.onUnknownRoute(_forwardRouteSettingsStack.removeLast());
      } else {
        rethrow;
      }
    }

    return push(route, forwardPushing: true);
  }
}

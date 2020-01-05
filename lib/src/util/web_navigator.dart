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
            'Navigator operation requested with a context that does not include a Navigator.\n'
            'The context used to push or pop routes from the Navigator must be that of a '
            'widget that is a descendant of a Navigator widget.');
      }
      return true;
    }());
    return navigator;
  }

  @override
  WebNavigatorState createState() => WebNavigatorState();
}

class WebNavigatorState extends NavigatorState {
  String _prevRoute;

  @override
  Future<T> push<T extends Object>(Route<T> route) {
    if (_prevRoute == route.settings.name) return null;
    _prevRoute = route.settings.name;
    return super.push(route);
  }
}

class BidirectionalRouteManager extends NavigatorObserver {
  final Queue<Route> _backwardStack = Queue();

  final Queue<Route> _forwardStack = Queue();

  @override
  void didPush(Route route, Route previousRoute) {
    _backwardStack.addLast(previousRoute);
  }

  @override
  void didPop(Route route, Route previousRoute) {
    _forwardStack.addLast(_backwardStack.removeLast());
  }
}

import 'dart:collection';

import 'package:flutter/widgets.dart';

/// Web환경에 맞는 Navigating을 구현한 [Navigator]
///
/// [Navigator]를 상속하며 [Navigator]의 static 함수를 따라서 구현.
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

/// [WebNavigator]의 State.
///
/// Forward, backward navigating을 구현.
class WebNavigatorState extends NavigatorState {
  /// backward page들의 stack.
  ///
  /// [pushForward]시 [_forwardRouteSettingsStack]에 넘겨줄 [RouteSettings]를 가짐.
  final Queue<RouteSettings> _backwardSettingsStack = Queue();

  /// forward page들의 stack.
  ///
  /// [pushForward]시 Navigating할 [RouteSettings]를 가짐.
  final Queue<RouteSettings> _forwardRouteSettingsStack = Queue();

  /// 현재 Route를 기준으로 전 route를 내보냄.
  String get backwardRoute {
    // 마지막 _backwardSettingsStack 마지막 item은 현재 route.
    if (_backwardSettingsStack.length == 1) return null;

    return _backwardSettingsStack
        .elementAt(_backwardSettingsStack.length - 2)
        .name;
  }

  /// 현재 Route를 기준으로 후 route를 내보냄.
  String get forwardRoute {
    if (_forwardRouteSettingsStack.isEmpty) return null;

    return _forwardRouteSettingsStack.last.name;
  }

  /// [Navigator.push]와 같은 동작을 하나 Web환경에 필요한 기능을 추가.
  ///
  /// 같은 route가 push될 경우 무시.
  /// Forward pushing이 아닐 경우 forward stack을 초기화하여 forward navigation을 방지.
  /// Backward route stack 관리.
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

  /// [Navigator.pop]와 같은 동작을 하나 Web환경에 필요한 기능을 추가.
  ///
  /// Backward, forward route stack 관리.
  @override
  bool pop<T>([T result]) {
    _forwardRouteSettingsStack.addLast(_backwardSettingsStack.removeLast());

    return super.pop(result);
  }

  /// Web 브라우저의 forward navigation 구현.
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

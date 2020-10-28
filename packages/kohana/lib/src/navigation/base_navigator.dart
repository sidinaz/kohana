import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kohana/src/navigation/custom_navigator.dart';
import 'package:routex/routex.dart' as routex;

class BaseNavigator {
  final routex.RoutexNavigator routexNavigator;
  final String prefix;

  routex.Router get router => routexNavigator.router;

  BaseNavigator({routex.RoutexNavigator routexNavigator, String prefix = "", bool useCustomNavigator = true})
      : this.routexNavigator =
            routexNavigator ?? (useCustomNavigator ? CustomNavigator.instance : routex.RoutexNavigator.shared),
        this.prefix = prefix;

  Future<T> push<T extends Object>(Object path, BuildContext context, [Map<String, dynamic> params]) async =>
      routexNavigator.push("$prefix$path", context, params);

  Widget view(Object path, [Map<String, dynamic> params]) => routex.FutureObserver(
        future: routexNavigator.asWidgetBuilderFuture(
          "$prefix$path",
          params,
        ),
        onSuccess: (context, wb) => wb(context),
      );

  Future<T> replaceRoot<T extends Object>(Object path, BuildContext context, [Map<String, dynamic> params]) =>
      routexNavigator.replaceRoot("$prefix$path", context, params);

  static PageRoute<T> pageRoute<T>({@required WidgetBuilder builder, @required String name, Object arguments}) =>
      Platform.isIOS
          ? CupertinoPageRoute(builder: builder)
          : MaterialPageRoute(
              builder: builder,
              settings: RouteSettings(
                name: name,
                arguments: arguments,
              ),
            );

  static Route onGenerateRoute(RouteSettings routeSettings) {
    final WidgetBuilder wb = routeSettings.arguments;
    final String name = routeSettings.name;
    return pageRoute(builder: wb, name: name, arguments: wb);
  }
}

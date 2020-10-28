
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routex/routex.dart' as routex;

class CustomNavigator extends routex.RoutexNavigator {
  static routex.RoutexNavigator instance = CustomNavigator();

  CustomNavigator([routex.Router router]) : super(router != null ? router : routex.Router.router());

  @override
  Future<T> push<T extends Object>(String path, BuildContext context, [Map<String, dynamic> params]) async {
    try {
      WidgetBuilder widgetBuilder = await asWidgetBuilderFuture(
        path,
        params,
      );
      var result = await  Navigator.of(context).pushNamed(path, arguments: widgetBuilder);
      return result as T;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<T> pushReplacement<T extends Object>(String path, BuildContext context, [Map<String, dynamic> params]) =>
      super.pushReplacement(
        path,
        context,
        params,
      );

  @override
  Future<T> replaceRoot<T extends Object>(String path, BuildContext context, [Map<String, dynamic> params]) async {
    WidgetBuilder widgetBuilder = await asWidgetBuilderFuture(
      path,
      params,
    );
    return Navigator.pushNamedAndRemoveUntil(
      context,
      path,
      (_) => false,
      // (Route route) => route.settings.name == path,
      arguments: widgetBuilder,
    );
  }
}

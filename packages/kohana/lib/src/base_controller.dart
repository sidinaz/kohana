import 'package:daggerito/daggerito.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routex/routex.dart' as routex;

import 'di/di.dart';

class BaseController implements routex.Controller {
  final Component component;

  String get prefix => "";

  BaseController(this.component);

  @override
  void bindRouter(routex.Router router) {
    router.routeWithRegex(r"^" + prefix + r"\/(?<action>[a-zA-Z0-9]+)$").handler(handler);
  }

  WidgetBuilder handler(routex.RoutingContext context) => (context.params().containsKey("arg1") && context.getParam("arg1") is DependencyContainerRegisterAction)
        ? (c) => component.createSubComponent(context.getParam("arg1"))<Widget>(context.getParam("action"))
        : (c) => component<Widget>(context.getParam("action"));
}

extension AddMoreExt on Component {
  Component createSubComponent(DependencyContainerRegisterAction register) => SubComponent(
        this,
        modules: [
          _AnonymousModule(register),
        ],
      );
}

class _AnonymousModule implements Module {
  final DependencyContainerRegisterAction action;

  _AnonymousModule(this.action);

  @override
  void register(DependencyContainer container) => action(container);
}

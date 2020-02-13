import 'package:daggerito/daggerito.dart';
import 'package:flutter/material.dart';
import 'package:routex/routex.dart';

class CreateComponentHandler<T extends Component>
    implements Handler<RoutingContext> {
  static const key = "component";
  final Future<T> Function(RoutingContext) factory;

  CreateComponentHandler({@required this.factory});

  @override
  Future<void> handle(RoutingContext context) async =>
      context.put(key, await factory(context)).next();
}

//helper to speed up container calls
extension DaggeritoComponentExtensions on RoutingContext {
  T call<T>([String tag]) {
    T object = get(CreateComponentHandler.key).container.resolve<T>(tag);
    assert(object != null, """
        "Missing definition for $T type, check module for definitions and ensure that provided component contains that module
         or collaborates with component that contains it. ${this.normalisedPath()}"
        """);
    return object;
  }

  /// assumes that component has already putted into context
  T getComponent<T extends Component>([String withKey]) =>
      get(withKey ?? CreateComponentHandler.key);
}

extension UseComponentAsHandler<T extends Component> on T {
  CreateComponentHandler asHandler() =>
      CreateComponentHandler(factory: (_) async => this);
}

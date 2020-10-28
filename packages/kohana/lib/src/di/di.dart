import 'package:daggerito/daggerito.dart';

typedef DependencyContainerRegisterAction = void Function(DependencyContainer container);

class ComponentDependencyContainer extends DependencyContainer {
  Component component;

  ComponentDependencyContainer({bool silent}) : super(silent: silent) {
    this.register(($) => component);
  }
}

DependencyContainerRegisterAction registerSingleItem<T>(T model) =>
        (DependencyContainer container) => container.register(
          ($) => model,
    );

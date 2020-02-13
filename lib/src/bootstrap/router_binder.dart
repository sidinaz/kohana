import 'package:kohana/src/bootstrap/router_bindable.dart';
import 'package:routex/routex.dart';

typedef Router RouterFactory();

class RouterBinder {
  final List<RouterBindable> binders;
  final RouterFactory routerFactory;

  RouterBinder([this.binders = const [], this.routerFactory]);

  void bind() {
    final Router router = routerFactory != null
        ? routerFactory()
        : RoutexNavigator.newInstance().router;
    binders.forEach((c) => c.bindRouter(router));
  }
}

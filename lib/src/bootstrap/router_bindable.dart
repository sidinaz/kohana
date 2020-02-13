import 'package:routex/routex.dart';

class RouterBindable {
  final String path;
  final List<Controller> controllers;
  final Function(Router) before;
  final Function(Router) after;

  RouterBindable({this.path, this.controllers, this.before, this.after});

  void bindRouter(Router router) {
    if (before != null) {
      before(router);
    }
    if (controllers != null) {
      if (path != null) {
        final subRouter = Router.router();
        controllers.forEach((c) => c.bindRouter(subRouter));
        router.mountSubRouter(
          path,
          subRouter,
        );
      } else {
        controllers.forEach((c) => c.bindRouter(router));
      }
    }
    if (after != null) {
      after(router);
    }
  }
}

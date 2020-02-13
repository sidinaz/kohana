import 'package:kohana/src/bootstrap/router_bindable.dart';
import 'package:kohana/src/bootstrap/titanium_app.dart';
import 'package:kohana/src/handler/auth_handler.dart';
import 'package:kohana/src/handler/create_component_handler.dart';
import 'package:routex/routex.dart';

class AppGeneralBindable extends RouterBindable {
  final Controller publicController;
  final String publicPath;

  AppGeneralBindable({this.publicController, this.publicPath})
      : super(
          before: (router) {
            router.route("/*").handler(
                  TitaniumApp.appComponent.asHandler(),
                );

            router.route("/app/*").handler(
                  AuthHandler(redirectTo: publicPath ?? "/public/"),
                );
          },
          controllers: [
            publicController,
          ],
        );
}

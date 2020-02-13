import 'package:daggerito/daggerito.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kohana/src/bootstrap/router_binder.dart';
import 'package:kohana/src/event.dart';
import 'package:kohana/src/event_bus.dart';
import 'package:kohana/src/rx_common.dart';
import 'package:kohana/src/view.dart';

typedef Future<T> ComponentFactory<T extends Component>();

mixin TitaniumApp<T extends Component> on BaseView {
  ComponentFactory<T> get appComponentFactory;

  RouterBinder get binder;

  static Component get appComponent => _fieldsInstance.appComponent;

  static Component get appSubComponent => _fieldsInstance.appSubComponent;

  static bool get subComponentMounted => appSubComponent != null;
  static _Fields _fieldsInstance;

  bool get isReady => _isReady != null ? _isReady.value : false;
  ValueNotifier<bool> _isReady;
  _Fields fields;

  void _createAppComponent() {
    var subscription =
        appComponentFactory().asStream().listen(_appComponentCreated);
    disposeBag.add(subscription);
  }

  void _appComponentCreated(T appComponent) {
    fields.appComponent = appComponent;
    onAppComponentCreated(appComponent);
  }

  void onAppComponentCreated(T appComponent);

  void startApplication() {
    bindRouter();
    _isReady.value = true;
  }

  void restartApplication() {
    _isReady.value = false;
    clearViews();
    fields.resetSubComponent();
    onAppComponentCreated(fields.appComponent);
  }

  void bindRouter() => binder.bind();

  @override
  void handleManagedFields() {
    fields = _fieldsInstance = managedField(() => _Fields());
    _isReady = useState(false);
  }

  @override
  void componentDidMount() {
    _createAppComponent();
    disposeBag.addAll([
      EventBus().listen<AppEvent>(($) {
        restartApplication();
      }, (appEvent) => appEvent.type == AppEventType.RESTART),
    ]);
  }
}

class _Fields {
  Component appComponent;
  Component appSubComponent;

  void resetSubComponent() {
    appSubComponent = null;
  }
}

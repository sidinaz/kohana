import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kohana/src/route_info.dart';
import 'package:kohana/src/view_model.dart';
import 'package:routex/routex.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
abstract class BaseView<T extends BaseViewModel> extends HookWidget {
  _Fields _managedFields;
  ValueNotifier<int> stateTrigger;
  T model;

  CompositeSubscription get disposeBag => _managedFields.disposeBag;

  BuildContext get context => _managedFields.context;

  bool get mounted => _managedFields.mounted;

  get managedField => useMemoized;

  BaseView({Key key}) : super(key: key);

  ///use [buildWidget] method instead [build]]
  Widget buildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    runHooks();
    return buildWidget(context);
  }

  WidgetBuilder managedView(String path, [Map<String, dynamic> params]) =>
      _managedFields.managedViews[RouteInfo(path, params: params)] ??=
          RoutexNavigator.shared.get(path, params);

  void clearViews() => _managedFields.managedViews.clear();

  //explicitly update state when working with non reactive data
  void setState([VoidCallback fn]) {
    if (fn != null) fn();
    ++stateTrigger.value;
  }

  /// https://reactjs.org/docs/hooks-effect.html
  @mustCallSuper
  void runHooks() {
    _handleManagedFields();
    useEffect(_handleLifecycleEvents, []);
  }

  void _handleManagedFields() {
    final context = useContext();
    stateTrigger = useState(0);
    _managedFields = managedField(() => _Fields(context));
    _managedFields.context = context;
    handleManagedFields();
  }

  void _componentDidMount() {
    if (model != null) {
      model.start();
    }
    _managedFields.mounted = true;
    componentDidMount();
  }

  void _componentWillUnmount() {
    if (model != null) {
      model.dispose();
    }
    _managedFields.mounted = false;
    disposeBag.clear();
    componentWillUnmount();
  }

  Dispose _handleLifecycleEvents() {
    _componentDidMount();
    return _componentWillUnmount;
  }

  void handleManagedFields() {}

  void componentDidMount() {}

  void componentWillUnmount() {}
}

class _Fields {
  final CompositeSubscription disposeBag = CompositeSubscription();
  final Map<RouteInfo, WidgetBuilder> managedViews = Map();
  var mounted = false;
  BuildContext context;

  _Fields(this.context);
}

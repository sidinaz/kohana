import 'package:rxdart/rxdart.dart';

import 'model.dart';
import 'view_state.dart';

abstract class BaseViewModel<T extends BaseModel> {
  CompositeSubscription disposeBag = CompositeSubscription();

  T data;

  void start() {}

  void handleError(Object error) {
    print(error);
    data.setActivity(ViewState.Error);
  }

  void dispose() => disposeBag.clear();

  get isWaiting => data.isWaiting;

  T call() => data;
}

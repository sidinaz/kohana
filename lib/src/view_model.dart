import 'package:kohana/src/model.dart';
import 'package:kohana/src/view_state.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel<T extends BaseModel> {
  CompositeSubscription disposeBag = CompositeSubscription();

  T data;

  void start() {}

  void handleError(Object error) {
    print(error);
    data.setActivity(ViewState.Error);
  }

  void dispose() => disposeBag.clear();

  Stream<bool> get isWaiting => data.isWaiting;

  T call() => data;
}

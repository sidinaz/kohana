import 'package:kohana/src/event.dart';
import 'package:kohana/src/event_bus.dart';
import 'package:kohana/src/view_state.dart';
import 'package:rxdart/rxdart.dart';

class BaseModel {
  final BehaviorSubject<ViewState> _activity;

  Stream<bool> get isWaiting =>
      _activity.map((activity) => activity == ViewState.Busy);

  Stream<bool> get hasError =>
      _activity.map((activity) => activity == ViewState.Error);

  Stream<bool> get hasData => _activity
      .where((a) => [ViewState.Done, ViewState.Error].contains(a))
      .scan((acc, curr, i) => curr == ViewState.Done, false)
      .startWith(_activity.value == ViewState.Done);

  BaseModel() : this._activity = BehaviorSubject.seeded(ViewState.Idle);

  void setActivity(ViewState activity) {
    EventBus()
        .push(AppEvent(AppEventType.IS_WAITING, activity == ViewState.Busy));
    _activity.add(activity);
  }
}

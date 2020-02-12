import 'dart:async';

import 'package:rxdart/rxdart.dart';

typedef _Predicate<T> = bool Function(T event);
typedef _Handler<T> = void Function(T event);

class EventBus {
  // ignore: close_sinks
  static final _source = PublishSubject();
  static final EventBus _instance = EventBus._();

  EventBus._();

  factory EventBus() => _instance;

  Stream asStream() => _source;

  StreamSubscription call(_Handler handler, [_Predicate predicate]) =>
      listen(handler, predicate);

  StreamSubscription listen<T>(_Handler<T> handler,
          [_Predicate<T> predicate]) =>
      (T == dynamic)
          ? asStream().listen(handler)
          : asStream()
              .where((event) => event is T)
              .cast<T>()
              .where((object) => predicate != null ? predicate(object) : true)
              .listen(handler);

  void push<T>(T event) => _source.add(event);
}

extension aaaa on Stream {
  StreamSubscription listenForAppEvent<T>(_Handler<T> handler,
          [_Predicate<T> predicate]) =>
      (T == dynamic)
          ? this.listen(handler)
          : this
              .where((event) => event is T)
              .cast<T>()
              .where((object) => predicate != null ? predicate(object) : true)
              .listen(handler);
}

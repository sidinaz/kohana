import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Signal {}

extension AddListOfSubscriptions on CompositeSubscription {
  /// Adds new subscription to this composite.
  /// Throws an exception if this composite was disposed
  /// cancel_subscriptions
  void addAll(List<StreamSubscription> subscriptions) => subscriptions.forEach((subscription) => add(subscription));
}

extension asSignalExtension<T> on Stream<T> {
  Stream<Signal> asSignal<S>() => map((_) => Signal());
}

class Variable<T> {
  final BehaviorSubject<T> _subject;

  Variable._(this._subject);

  Stream<T> get stream => _subject.stream;

  factory Variable(T value, {bool initWithNull = false}) => Variable._(value != null
      ? BehaviorSubject.seeded(value)
      : (initWithNull ? BehaviorSubject.seeded(null) : BehaviorSubject()));

  void add(T event) => _subject.add(event);

  T get value => _subject.value;

  Future<dynamic> close() => _subject.close();
}

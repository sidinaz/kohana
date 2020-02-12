import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Signal {}

extension AddListOfSubscriptions on CompositeSubscription {
  /// Adds new subscription to this composite.
  /// Throws an exception if this composite was disposed
  /// cancel_subscriptions
  void addAll(List<StreamSubscription> subscriptions) =>
      subscriptions.forEach((subscription) => add(subscription));
}

extension asSignalExtension<T> on Stream<T> {
  Stream<Signal> asSignal<S>() => map((_) => Signal());
}

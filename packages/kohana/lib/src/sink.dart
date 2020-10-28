import 'package:kohana/src/rx_common.dart';
import 'package:rxdart/rxdart.dart';

class Sink1<A> {
  final BehaviorSubject<A> _subject1;

  Stream<A> get item1 => _subject1;

  A get item1Value => _subject1.value;

  Sink1({A seed1})
      : _subject1 =
            seed1 == null ? BehaviorSubject() : BehaviorSubject.seeded(seed1);

  void add1(A value) => _subject1.add(value);
}

class Sink2<A, B> extends Sink1<A> {
  final BehaviorSubject<B> _subject2;

  Stream<B> get item2 => _subject2;

  B get item2Value => _subject2.value;

  Sink2({A seed1, B seed2})
      : _subject2 =
            seed2 == null ? BehaviorSubject() : BehaviorSubject.seeded(seed2),
        super(seed1: seed1);

  void add2(B value) => _subject2.add(value);
}

class Sink3<A, B, C> extends Sink2<A, B> {
  final BehaviorSubject<C> _subject3;

  Stream<C> get item3 => _subject3;

  C get item3Value => _subject3.value;

  Sink3({A seed1, B seed2, C seed3})
      : _subject3 =
            seed3 == null ? BehaviorSubject() : BehaviorSubject.seeded(seed3),
        super(seed1: seed1, seed2: seed2);

  void add3(C value) => _subject3.add(value);
}

class Sink4<A, B, C, D> extends Sink3<A, B, C> {
  final BehaviorSubject<D> _subject4;

  Stream<D> get item4 => _subject4;

  D get item4Value => _subject4.value;

  Sink4({A seed1, B seed2, C seed3, D seed4})
      : _subject4 =
            seed4 == null ? BehaviorSubject() : BehaviorSubject.seeded(seed4),
        super(seed1: seed1, seed2: seed2, seed3: seed3);

  void add4(D value) => _subject4.add(value);
}

mixin SingleEventSinkMixin {
  final _eventSubject = PublishSubject<Signal>();

  Stream<Signal> get event => _eventSubject;

  get addEvent => () => _eventSubject.add(Signal());
}

mixin DoubleEventSinkMixin {
  final _eventSubject = PublishSubject<Signal>();

  Stream<Signal> get event => _eventSubject;

  get addEvent => () => _eventSubject.add(Signal());

  final _eventSubject2 = PublishSubject<Signal>();

  Stream<Signal> get event2 => _eventSubject2;

  get addEvent2 => () => _eventSubject2.add(Signal());
}

mixin EventSinkMixin3 {
  final _eventSubject = PublishSubject<Signal>();

  Stream<Signal> get event => _eventSubject;

  get addEvent => () => _eventSubject.add(Signal());

  final _eventSubject2 = PublishSubject<Signal>();

  Stream<Signal> get event2 => _eventSubject2;

  get addEvent2 => () => _eventSubject2.add(Signal());

  final _eventSubject3 = PublishSubject<Signal>();

  Stream<Signal> get event3 => _eventSubject3;

  get addEvent3 => () => _eventSubject3.add(Signal());
}

mixin EventSinkMixin4 {
  final _eventSubject = PublishSubject<Signal>();

  Stream<Signal> get event => _eventSubject;

  get addEvent => () => _eventSubject.add(Signal());

  final _eventSubject2 = PublishSubject<Signal>();

  Stream<Signal> get event2 => _eventSubject2;

  get addEvent2 => () => _eventSubject2.add(Signal());

  final _eventSubject3 = PublishSubject<Signal>();

  Stream<Signal> get event3 => _eventSubject3;

  get addEvent3 => () => _eventSubject3.add(Signal());

  final _eventSubject4 = PublishSubject<Signal>();

  Stream<Signal> get event4 => _eventSubject4;

  get addEvent4 => () => _eventSubject4.add(Signal());
}

mixin EventSinkMixin5 {
  final _eventSubject = PublishSubject<Signal>();

  Stream<Signal> get event => _eventSubject;

  get addEvent => () => _eventSubject.add(Signal());

  final _eventSubject2 = PublishSubject<Signal>();

  Stream<Signal> get event2 => _eventSubject2;

  get addEvent2 => () => _eventSubject2.add(Signal());

  final _eventSubject3 = PublishSubject<Signal>();

  Stream<Signal> get event3 => _eventSubject3;

  get addEvent3 => () => _eventSubject3.add(Signal());

  final _eventSubject4 = PublishSubject<Signal>();

  Stream<Signal> get event4 => _eventSubject4;

  get addEvent4 => () => _eventSubject4.add(Signal());

  final _eventSubject5 = PublishSubject<Signal>();

  Stream<Signal> get event5 => _eventSubject5;

  get addEvent5 => () => _eventSubject5.add(Signal());
}

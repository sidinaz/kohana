class Tuple1<A> {
  final A item1;

  Tuple1(this.item1);

  @override
  String toString() {
    return 'Tuple1{item1: $item1}';
  }
}

class Tuple2<A, B> {
  final A item1;
  final B item2;

  Tuple2(this.item1, this.item2);

  @override
  String toString() {
    return 'Tuple2{item1: $item1, item2: $item2}';
  }
}

class Tuple3<A, B, C> {
  final A item1;
  final B item2;
  final C item3;

  Tuple3(this.item1, this.item2, this.item3);

  @override
  String toString() {
    return 'Tuple3{item1: $item1, item2: $item2, item3: $item3}';
  }
}

class Tuple4<A, B, C, D> {
  final A item1;
  final B item2;
  final C item3;
  final D item4;

  Tuple4(this.item1, this.item2, this.item3, this.item4);

  @override
  String toString() {
    return 'Tuple4{item1: $item1, item2: $item2, item3: $item3, item4: $item4}';
  }
}

class Tuple5<A, B, C, D, E> {
  final A item1;
  final B item2;
  final C item3;
  final D item4;
  final E item5;

  Tuple5(this.item1, this.item2, this.item3, this.item4, this.item5);

  @override
  String toString() {
    return 'Tuple5{item1: $item1, item2: $item2, item3: $item3, item4: $item4, item5: $item5}';
  }
}

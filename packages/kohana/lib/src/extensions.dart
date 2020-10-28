import 'package:kohana/kohana.dart';
import 'package:rxdart/rxdart.dart';

import 'input_value.dart';

extension AsConsumerStringExt on BehaviorSubject<String> {
  Consumer<InputValue> get asInputValueConsumer => (inputValue) => this.add(inputValue.value);
}

extension AsConsumerIntExt on BehaviorSubject<int> {
  Consumer<InputValue> get asInputValueConsumer => (inputValue) => this.add(int.parse(inputValue.value));
}

extension AsInputValueStreamStringExt on BehaviorSubject<String> {
  Stream<InputValue> get asInputValueStream => this.map(($) => InputValue($));
}

extension AsInputValueStreamIntExt on BehaviorSubject<int> {
  Stream<InputValue> get asInputValueStream => this.map(($) => InputValue("${$}"));
}

extension VariableAsConsumerStringExt on Variable<String> {
  Consumer<InputValue> get asInputValueConsumer => (inputValue) => this.add(inputValue.value);
}

extension VariableAsConsumerIntExt on Variable<int> {
  Consumer<InputValue> get asInputValueConsumer => (inputValue) => this.add(int.parse(inputValue.value));
}

extension VariableAsInputValueStreamStringExt on Variable<String> {
  Stream<InputValue> get asInputValueStream => this.stream.map(($) => InputValue($));
}

extension VariableAsInputValueStreamIntExt on Variable<int> {
  Stream<InputValue> get asInputValueStream => this.stream.map(($) => InputValue("${$}"));
}

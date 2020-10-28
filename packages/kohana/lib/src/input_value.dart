class InputValue {
  String value;
  String validationMessage;
  bool fromInput;

  InputValue(this.value, {this.validationMessage, this.fromInput = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is InputValue && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

typedef void Consumer<T>(T value);

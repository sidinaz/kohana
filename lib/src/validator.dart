import 'package:flutter/foundation.dart';

abstract class Validator<T> {
  bool hasMatch(String pattern, String input) =>
      RegExp(pattern).hasMatch(input);

  /// checks the input against the given conditions
  bool isValid(T value);

  bool call(T value) => isValid(value);
}

class TextFieldValidator {
  /// the errorText to display when the validation fails
  final String errorText;
  final bool throws;
  final Validator<String> validator;

  final bool ignoreEmptyValues;

  TextFieldValidator(this.validator,
      {this.errorText, this.throws = true, this.ignoreEmptyValues = true});

  /// call is a special function that makes a class callable
  /// returns null if the input is valid otherwise it returns the provided error errorText
  String call(String value) {
    return validator == null
        ? null
        : (ignoreEmptyValues && value.isEmpty)
            ? null
            : validator.isValid(value)
                ? null
                : throws ? throw errorText : errorText;
  }
}

class RequiredValidator extends Validator<String> {
  @override
  bool isValid(String value) => value.isNotEmpty;

  @override
  bool call(String value) => isValid(value);
}

class MaxLengthValidator extends Validator<String> {
  final int max;

  MaxLengthValidator(this.max);

  @override
  bool isValid(String value) => value.length <= max;
}

class MinLengthValidator extends Validator<String> {
  final int min;

  MinLengthValidator(this.min);

  @override
  bool isValid(String value) => value.length >= min;
}

class TextFieldMinLengthValidator extends TextFieldValidator {
  TextFieldMinLengthValidator(int min,
      {String errorText = "Minimum characters"})
      : super(MinLengthValidator(min), errorText: errorText);
}

class TextFieldMaxLengthValidator extends TextFieldValidator {
  TextFieldMaxLengthValidator(int max,
      {String errorText = "Maximum characters"})
      : super(MaxLengthValidator(max), errorText: errorText);
}

class TextFieldAlphanumericValidator extends TextFieldValidator {
  TextFieldAlphanumericValidator({String errorText = "alphanumeric_Validator"})
      : super(AlphanumericValidator(), errorText: errorText);
}

class TextFieldAlwaysValidValidator extends TextFieldValidator {
  TextFieldAlwaysValidValidator() : super(AlwaysValidValidator());
}

class EmailValidator extends Validator<String> {
  /// regex pattern to validate email inputs.
  final Pattern _emailPattern =
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";

  @override
  bool isValid(String value) => hasMatch(_emailPattern, value);
}

class AlphanumericValidator extends Validator<String> {
  /// regex pattern to validate email inputs.
  final Pattern _pattern = r"^[a-zA-Z0-9]+$";

  @override
  bool isValid(String value) => hasMatch(_pattern, value);
}
//"^[a-zA-Z0-9]+\$"

class PatternValidator extends Validator<String> {
  final Pattern pattern;

  PatternValidator(this.pattern);

  @override
  bool isValid(String value) => hasMatch(pattern, value);
}

class AlwaysValidValidator extends Validator<String> {
  @override
  bool isValid(String value) => true;
}

class MultiValidator extends Validator {
  final List<Validator> validators;

  MultiValidator(List<Validator> validators)
      : this.validators = validators.length != 0
            ? validators
            : [
                AlwaysValidValidator(),
              ];

  @override
  bool isValid(value) {
    for (Validator validator in validators) {
      if (!validator.isValid(value)) {
        return false;
      }
    }
    return true;
  }

  @override
  bool call(dynamic value) => isValid(value);
}

class TextFieldMultiValidator extends TextFieldValidator {
  final List<TextFieldValidator> validators;
  String _errorText = '';

  TextFieldMultiValidator(List<TextFieldValidator> validators,
      {bool throws = true})
      : this.validators = validators.length != 0
            ? validators
            : [
                TextFieldAlwaysValidValidator(),
              ],
        super(null, throws: throws);

  bool isValid(value) {
    for (TextFieldValidator validator in validators) {
      if (!validator.validator.isValid(value)) {
        _errorText = validator.errorText;
        return false;
      }
    }
    _errorText = '';
    return true;
  }

  @override
  String call(dynamic value) {
    return (ignoreEmptyValues && value.isEmpty)
        ? null
        : isValid(value) ? null : throws ? throw _errorText : _errorText;
  }
}

/// a special match validator to check if the input equals another provided value;
class MatchValidator {
  final String errorText;

  MatchValidator({@required this.errorText});

  String validateMatch(String value, String value2) {
    return value == value2 ? null : errorText;
  }
}

import 'package:flutter/foundation.dart';

/// A controller for managing numpad input state and interactions.
///
/// The [NumpadController] manages the current input value and provides
/// callbacks for various numpad actions like input, delete, clear, and submit.
///
/// Example:
/// ```dart
/// final controller = NumpadController(
///   maxLength: 6,
///   onInput: (value) => print('Current value: $value'),
///   onSubmit: (value) => print('Submitted: $value'),
/// );
/// ```
class NumpadController extends ChangeNotifier {
  /// Creates a [NumpadController].
  ///
  /// The [maxLength] parameter limits the number of digits that can be entered.
  /// If null, there is no limit.
  NumpadController({
    this.maxLength,
    this.onInput,
    this.onDelete,
    this.onClear,
    this.onSubmit,
  });

  String _value = '';
  final int? maxLength;

  /// Callback invoked when a digit is added to the input.
  ///
  /// The callback receives the current complete value as a string.
  final ValueChanged<String>? onInput;

  /// Callback invoked when the delete action is triggered.
  final VoidCallback? onDelete;

  /// Callback invoked when the clear action is triggered.
  final VoidCallback? onClear;

  /// Callback invoked when the submit action is triggered.
  ///
  /// The callback receives the current complete value as a string.
  final ValueChanged<String>? onSubmit;

  /// The current input value as a string.
  String get value => _value;

  /// The length of the current input value.
  int get length => _value.length;

  /// Whether the current input value is empty.
  bool get isEmpty => _value.isEmpty;

  /// Whether the current input value is not empty.
  bool get isNotEmpty => _value.isNotEmpty;

  /// Adds a digit to the current input value.
  ///
  /// The [digit] must be a single character string containing a digit (0-9).
  /// If [maxLength] is set and the current length equals or exceeds it,
  /// the digit will not be added.
  ///
  /// Throws [ArgumentError] if [digit] is not a valid single digit.
  void addDigit(String digit) {
    if (!_isValidDigit(digit)) {
      throw ArgumentError('Invalid digit: $digit. Must be a single digit 0-9.');
    }

    if (maxLength != null && _value.length >= maxLength!) {
      return;
    }

    _value += digit;
    onInput?.call(_value);
    notifyListeners();
  }

  /// Removes the last digit from the current input value.
  ///
  /// Does nothing if the value is already empty.
  void deleteDigit() {
    if (_value.isEmpty) {
      return;
    }

    _value = _value.substring(0, _value.length - 1);
    onDelete?.call();
    notifyListeners();
  }

  /// Clears all digits from the current input value.
  void clear() {
    _value = '';
    onClear?.call();
    notifyListeners();
  }

  /// Submits the current input value.
  ///
  /// Invokes the [onSubmit] callback with the current value.
  void submit() {
    onSubmit?.call(_value);
  }

  /// Sets the input value programmatically.
  ///
  /// The [value] must contain only digits (0-9).
  /// If [maxLength] is set, the value will be truncated to fit.
  ///
  /// Throws [ArgumentError] if [value] contains non-digit characters.
  void setValue(String value) {
    if (!_isValidValue(value)) {
      throw ArgumentError(
        'Invalid value: $value. Must contain only digits 0-9.',
      );
    }

    if (maxLength != null && value.length > maxLength!) {
      _value = value.substring(0, maxLength!);
    } else {
      _value = value;
    }

    notifyListeners();
  }

  bool _isValidDigit(String digit) {
    return RegExp(r'^[0-9]$').hasMatch(digit);
  }

  bool _isValidValue(String value) {
    return RegExp(r'^[0-9]*$').hasMatch(value);
  }
}

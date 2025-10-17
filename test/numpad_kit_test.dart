import 'package:flutter_test/flutter_test.dart';
import 'package:numpad_kit/numpad_kit.dart';

void main() {
  group('NumpadController', () {
    test('addDigit adds digit to value', () {
      final controller = NumpadController();
      controller.addDigit('5');
      expect(controller.value, '5');
      controller.addDigit('3');
      expect(controller.value, '53');
    });

    test('deleteDigit removes last digit', () {
      final controller = NumpadController();
      controller.addDigit('1');
      controller.addDigit('2');
      controller.addDigit('3');
      expect(controller.value, '123');
      controller.deleteDigit();
      expect(controller.value, '12');
    });

    test('clear resets value', () {
      final controller = NumpadController();
      controller.addDigit('1');
      controller.addDigit('2');
      controller.clear();
      expect(controller.value, '');
      expect(controller.isEmpty, true);
    });

    test('maxLength constraint prevents overflow', () {
      final controller = NumpadController(maxLength: 3);
      controller.addDigit('1');
      controller.addDigit('2');
      controller.addDigit('3');
      controller.addDigit('4'); // Should be ignored
      expect(controller.value, '123');
      expect(controller.length, 3);
    });

    test('setValue sets value programmatically', () {
      final controller = NumpadController();
      controller.setValue('999');
      expect(controller.value, '999');
    });

    test('callbacks are invoked', () {
      String? inputValue;
      bool deleteCalled = false;
      bool clearCalled = false;
      String? submitValue;

      final controller = NumpadController(
        onInput: (value) => inputValue = value,
        onDelete: () => deleteCalled = true,
        onClear: () => clearCalled = true,
        onSubmit: (value) => submitValue = value,
      );

      controller.addDigit('5');
      expect(inputValue, '5');

      controller.deleteDigit();
      expect(deleteCalled, true);

      controller.clear();
      expect(clearCalled, true);

      controller.addDigit('7');
      controller.submit();
      expect(submitValue, '7');
    });

    test('invalid digit throws error', () {
      final controller = NumpadController();
      expect(() => controller.addDigit('a'), throwsArgumentError);
      expect(() => controller.addDigit('12'), throwsArgumentError);
    });
  });

  group('NumpadThemeData', () {
    test('copyWith merges correctly', () {
      final theme = NumpadThemeData.light();
      final modified = theme.copyWith(buttonSize: 100.0);
      expect(modified.buttonSize, 100.0);
      expect(modified.buttonColor, theme.buttonColor);
    });

    test('light theme has valid values', () {
      final theme = NumpadThemeData.light();
      expect(theme.buttonSize, greaterThanOrEqualTo(48.0));
      expect(theme.spacing, greaterThanOrEqualTo(0));
    });

    test('dark theme has valid values', () {
      final theme = NumpadThemeData.dark();
      expect(theme.buttonSize, greaterThanOrEqualTo(48.0));
      expect(theme.spacing, greaterThanOrEqualTo(0));
    });
  });
}

/// A fully customizable and themeable numeric keypad widget for Flutter.
///
/// This library provides a [Numpad] widget that displays a 3x4 grid of buttons
/// arranged like a phone keypad, with support for custom themes, extra buttons,
/// and keyboard input.
///
/// ## Features
///
/// - 🎨 Fully customizable appearance with theming
/// - 🎯 Controller-based state management
/// - ⌨️ Keyboard input support (web/desktop)
/// - 📱 Cross-platform compatibility
/// - 🔧 Custom button builder support
/// - ♿ Accessibility compliant
///
/// ## Basic Usage
///
/// ```dart
/// import 'package:numpad_kit/numpad_kit.dart';
///
/// Numpad(
///   controller: NumpadController(
///     onInput: (value) => print('Input: $value'),
///     onSubmit: (value) => print('Submitted: $value'),
///   ),
/// )
/// ```
///
/// ## Custom Theme
///
/// ```dart
/// NumpadTheme(
///   data: NumpadThemeData(
///     buttonColor: Colors.blue,
///     buttonTextColor: Colors.white,
///     buttonShape: NumpadButtonShape.circle,
///   ),
///   child: Numpad(controller: myController),
/// )
/// ```
library;

export 'src/numpad.dart';
export 'src/numpad_button.dart';
export 'src/numpad_controller.dart';
export 'src/numpad_theme.dart';
export 'src/utils/constants.dart';

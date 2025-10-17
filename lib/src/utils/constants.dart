import 'package:flutter/animation.dart';

/// Defines the shape of numpad buttons.
enum NumpadButtonShape {
  /// Circular button shape.
  circle,

  /// Square button shape with sharp corners.
  square,

  /// Square button shape with rounded corners.
  roundedSquare,
}

/// Default constants for the numpad widget.
class NumpadConstants {
  NumpadConstants._();

  /// Default button size in logical pixels.
  static const double defaultButtonSize = 72.0;

  /// Default spacing between buttons in logical pixels.
  static const double defaultSpacing = 12.0;

  /// Default animation duration for button interactions.
  static const Duration defaultAnimationDuration = Duration(milliseconds: 150);

  /// Default animation curve for button interactions.
  static const Curve defaultAnimationCurve = Curves.easeInOut;

  /// Default scale factor when button is pressed.
  static const double defaultPressedScale = 0.95;

  /// Default border radius for rounded buttons.
  static const double defaultBorderRadius = 12.0;

  /// Minimum button size for accessibility compliance.
  static const double minButtonSize = 48.0;

  /// Maximum button size for usability.
  static const double maxButtonSize = 120.0;
}

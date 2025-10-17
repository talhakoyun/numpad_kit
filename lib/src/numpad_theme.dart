import 'package:flutter/material.dart';
import 'utils/constants.dart';

/// Defines the visual properties of a numpad.
///
/// Used by [NumpadTheme] to control the appearance of numpad widgets.
///
/// Example:
/// ```dart
/// NumpadThemeData(
///   buttonColor: Colors.blue,
///   buttonTextColor: Colors.white,
///   buttonShape: NumpadButtonShape.circle,
/// )
/// ```
class NumpadThemeData {
  /// Creates a numpad theme data.
  const NumpadThemeData({
    this.backgroundColor = Colors.transparent,
    this.buttonColor = const Color(0xFFE0E0E0),
    this.buttonTextColor = const Color(0xFF000000),
    this.buttonBorderColor = Colors.transparent,
    this.buttonHoverColor = const Color(0xFFD0D0D0),
    this.buttonPressedColor = const Color(0xFFC0C0C0),
    this.disabledButtonColor = const Color(0xFFF5F5F5),
    this.disabledTextColor = const Color(0xFFBDBDBD),
    this.buttonSize = NumpadConstants.defaultButtonSize,
    this.spacing = NumpadConstants.defaultSpacing,
    this.buttonPadding = const EdgeInsets.all(8.0),
    this.numpadPadding = const EdgeInsets.all(16.0),
    this.buttonShape = NumpadButtonShape.roundedSquare,
    this.borderRadius = NumpadConstants.defaultBorderRadius,
    this.borderWidth = 0.0,
    this.textStyle = const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
    ),
    this.animationDuration = NumpadConstants.defaultAnimationDuration,
    this.animationCurve = NumpadConstants.defaultAnimationCurve,
    this.pressedScale = NumpadConstants.defaultPressedScale,
    this.shadows,
  })  : assert(
          buttonSize >= NumpadConstants.minButtonSize,
          'Button size must be at least ${NumpadConstants.minButtonSize} for accessibility',
        ),
        assert(spacing >= 0, 'Spacing cannot be negative'),
        assert(borderRadius >= 0, 'Border radius cannot be negative'),
        assert(borderWidth >= 0, 'Border width cannot be negative'),
        assert(
          pressedScale > 0 && pressedScale <= 1.0,
          'Pressed scale must be between 0 and 1.0',
        );

  /// Background color of the numpad container.
  final Color backgroundColor;

  /// Default color of numpad buttons.
  final Color buttonColor;

  /// Color of button text.
  final Color buttonTextColor;

  /// Color of button borders.
  final Color buttonBorderColor;

  /// Color of buttons when hovered (web/desktop).
  final Color buttonHoverColor;

  /// Color of buttons when pressed.
  final Color buttonPressedColor;

  /// Color of disabled buttons.
  final Color disabledButtonColor;

  /// Color of text on disabled buttons.
  final Color disabledTextColor;

  /// Size of each button (width and height).
  final double buttonSize;

  /// Spacing between buttons.
  final double spacing;

  /// Padding inside each button.
  final EdgeInsets buttonPadding;

  /// Padding around the entire numpad.
  final EdgeInsets numpadPadding;

  /// Shape of the buttons.
  final NumpadButtonShape buttonShape;

  /// Border radius for rounded buttons.
  final double borderRadius;

  /// Width of button borders.
  final double borderWidth;

  /// Text style for button labels.
  final TextStyle textStyle;

  /// Duration of button animations.
  final Duration animationDuration;

  /// Curve for button animations.
  final Curve animationCurve;

  /// Scale factor when button is pressed (0.0 to 1.0).
  final double pressedScale;

  /// Shadows applied to buttons.
  final List<BoxShadow>? shadows;

  /// Creates a light theme with Material Design 3 colors.
  factory NumpadThemeData.light() {
    return const NumpadThemeData(
      backgroundColor: Colors.transparent,
      buttonColor: Color(0xFFE8DEF8),
      buttonTextColor: Color(0xFF1D1B20),
      buttonBorderColor: Colors.transparent,
      buttonHoverColor: Color(0xFFD0BCFF),
      buttonPressedColor: Color(0xFFB69DF8),
      disabledButtonColor: Color(0xFFF5F5F5),
      disabledTextColor: Color(0xFFBDBDBD),
      buttonShape: NumpadButtonShape.roundedSquare,
      borderRadius: 12.0,
      textStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1D1B20),
      ),
      animationDuration: NumpadConstants.defaultAnimationDuration,
      animationCurve: NumpadConstants.defaultAnimationCurve,
    );
  }

  /// Creates a dark theme with appropriate contrast.
  factory NumpadThemeData.dark() {
    return const NumpadThemeData(
      backgroundColor: Colors.transparent,
      buttonColor: Color(0xFF4A4458),
      buttonTextColor: Color(0xFFE6E0E9),
      buttonBorderColor: Colors.transparent,
      buttonHoverColor: Color(0xFF5E5470),
      buttonPressedColor: Color(0xFF6F6585),
      disabledButtonColor: Color(0xFF2B2930),
      disabledTextColor: Color(0xFF625B71),
      buttonShape: NumpadButtonShape.roundedSquare,
      borderRadius: 12.0,
      textStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
        color: Color(0xFFE6E0E9),
      ),
      animationDuration: NumpadConstants.defaultAnimationDuration,
      animationCurve: NumpadConstants.defaultAnimationCurve,
    );
  }

  /// Creates a copy of this theme data with the given fields replaced.
  NumpadThemeData copyWith({
    Color? backgroundColor,
    Color? buttonColor,
    Color? buttonTextColor,
    Color? buttonBorderColor,
    Color? buttonHoverColor,
    Color? buttonPressedColor,
    Color? disabledButtonColor,
    Color? disabledTextColor,
    double? buttonSize,
    double? spacing,
    EdgeInsets? buttonPadding,
    EdgeInsets? numpadPadding,
    NumpadButtonShape? buttonShape,
    double? borderRadius,
    double? borderWidth,
    TextStyle? textStyle,
    Duration? animationDuration,
    Curve? animationCurve,
    double? pressedScale,
    List<BoxShadow>? shadows,
  }) {
    return NumpadThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      buttonBorderColor: buttonBorderColor ?? this.buttonBorderColor,
      buttonHoverColor: buttonHoverColor ?? this.buttonHoverColor,
      buttonPressedColor: buttonPressedColor ?? this.buttonPressedColor,
      disabledButtonColor: disabledButtonColor ?? this.disabledButtonColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      buttonSize: buttonSize ?? this.buttonSize,
      spacing: spacing ?? this.spacing,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      numpadPadding: numpadPadding ?? this.numpadPadding,
      buttonShape: buttonShape ?? this.buttonShape,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      textStyle: textStyle ?? this.textStyle,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      pressedScale: pressedScale ?? this.pressedScale,
      shadows: shadows ?? this.shadows,
    );
  }
}

/// An inherited widget that defines the visual properties for numpad widgets
/// in this widget's subtree.
///
/// Example:
/// ```dart
/// NumpadTheme(
///   data: NumpadThemeData.dark(),
///   child: Numpad(controller: myController),
/// )
/// ```
class NumpadTheme extends InheritedWidget {
  /// Creates a numpad theme that controls the visual properties of
  /// descendant numpad widgets.
  const NumpadTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The theme data for descendant numpad widgets.
  final NumpadThemeData data;

  /// Returns the [NumpadThemeData] from the closest [NumpadTheme] ancestor.
  ///
  /// If there is no ancestor, it returns a default theme based on the
  /// current [ThemeData.brightness].
  static NumpadThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<NumpadTheme>();
    if (theme != null) {
      return theme.data;
    }

    // Return default theme based on brightness
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? NumpadThemeData.dark()
        : NumpadThemeData.light();
  }

  @override
  bool updateShouldNotify(NumpadTheme oldWidget) {
    return data != oldWidget.data;
  }
}

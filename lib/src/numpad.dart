import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'numpad_button.dart';
import 'numpad_controller.dart';
import 'numpad_theme.dart';

/// A typedef for building custom numpad buttons.
///
/// The builder receives:
/// - [context]: The build context
/// - [value]: The button value (digit or symbol)
/// - [onPressed]: The callback to invoke when pressed
/// - [isEnabled]: Whether the button is enabled
typedef NumpadButtonBuilder = Widget Function(
  BuildContext context,
  String value,
  VoidCallback onPressed,
  bool isEnabled,
);

/// A customizable numeric keypad widget.
///
/// The [Numpad] widget displays a 3x4 grid of buttons arranged like a
/// phone keypad, with optional extra buttons for additional functionality.
///
/// Example:
/// ```dart
/// Numpad(
///   controller: NumpadController(
///     onInput: (value) => print('Input: $value'),
///   ),
/// )
/// ```
class Numpad extends StatefulWidget {
  /// Creates a numpad widget.
  const Numpad({
    this.controller,
    this.theme,
    this.buttonBuilder,
    this.onLeftExtraButton,
    this.onRightExtraButton,
    this.leftExtraButton,
    this.rightExtraButton,
    this.showLeftExtraButton = false,
    this.showRightExtraButton = false,
    this.padding,
    this.spacing,
    this.enableKeyboardInput = true,
    super.key,
  });

  /// The controller for managing numpad input state.
  final NumpadController? controller;

  /// The theme data for this numpad. If null, uses [NumpadTheme.of(context)].
  final NumpadThemeData? theme;

  /// Optional builder for creating custom button widgets.
  final NumpadButtonBuilder? buttonBuilder;

  /// Callback for the left extra button.
  final VoidCallback? onLeftExtraButton;

  /// Callback for the right extra button.
  final VoidCallback? onRightExtraButton;

  /// Custom widget for the left extra button.
  final Widget? leftExtraButton;

  /// Custom widget for the right extra button.
  final Widget? rightExtraButton;

  /// Whether to show the left extra button.
  final bool showLeftExtraButton;

  /// Whether to show the right extra button.
  final bool showRightExtraButton;

  /// Padding around the entire numpad. If null, uses theme padding.
  final EdgeInsets? padding;

  /// Spacing between buttons. If null, uses theme spacing.
  final double? spacing;

  /// Whether to enable keyboard input (for web/desktop).
  final bool enableKeyboardInput;

  @override
  State<Numpad> createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Request focus when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.enableKeyboardInput && mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleButtonPress(String value) {
    widget.controller?.addDigit(value);
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!widget.enableKeyboardInput) {
      return KeyEventResult.ignored;
    }

    if (event is KeyDownEvent) {
      final key = event.logicalKey;

      // Handle number keys
      if (key == LogicalKeyboardKey.digit0 ||
          key == LogicalKeyboardKey.numpad0) {
        _handleButtonPress('0');
        return KeyEventResult.handled;
      } else if (key == LogicalKeyboardKey.digit1 ||
          key == LogicalKeyboardKey.numpad1) {
        _handleButtonPress('1');
        return KeyEventResult.handled;
      } else if (key == LogicalKeyboardKey.digit2 ||
          key == LogicalKeyboardKey.numpad2) {
        _handleButtonPress('2');
        return KeyEventResult.handled;
      } else if (key == LogicalKeyboardKey.digit3 ||
          key == LogicalKeyboardKey.numpad3) {
        _handleButtonPress('3');
        return KeyEventResult.handled;
      } else if (key == LogicalKeyboardKey.digit4 ||
          key == LogicalKeyboardKey.numpad4) {
        _handleButtonPress('4');
        return KeyEventResult.handled;
      } else if (key == LogicalKeyboardKey.digit5 ||
          key == LogicalKeyboardKey.numpad5) {
        _handleButtonPress('5');
        return KeyEventResult.handled;
      } else if (key == LogicalKeyboardKey.digit6 ||
          key == LogicalKeyboardKey.numpad6) {
        _handleButtonPress('6');
        return KeyEventResult.handled;
      } else if (key == LogicalKeyboardKey.digit7 ||
          key == LogicalKeyboardKey.numpad7) {
        _handleButtonPress('7');
        return KeyEventResult.handled;
      } else if (key == LogicalKeyboardKey.digit8 ||
          key == LogicalKeyboardKey.numpad8) {
        _handleButtonPress('8');
        return KeyEventResult.handled;
      } else if (key == LogicalKeyboardKey.digit9 ||
          key == LogicalKeyboardKey.numpad9) {
        _handleButtonPress('9');
        return KeyEventResult.handled;
      }

      // Handle backspace
      if (key == LogicalKeyboardKey.backspace) {
        widget.controller?.deleteDigit();
        return KeyEventResult.handled;
      }

      // Handle enter
      if (key == LogicalKeyboardKey.enter ||
          key == LogicalKeyboardKey.numpadEnter) {
        widget.controller?.submit();
        return KeyEventResult.handled;
      }

      // Handle escape
      if (key == LogicalKeyboardKey.escape) {
        widget.controller?.clear();
        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
  }

  Widget _buildButton(
    BuildContext context,
    String value,
    NumpadThemeData theme, {
    Widget? customChild,
    VoidCallback? customCallback,
  }) {
    final onPressed = customCallback ?? () => _handleButtonPress(value);

    if (widget.buttonBuilder != null) {
      return widget.buttonBuilder!(context, value, onPressed, true);
    }

    return NumpadButton(
      value: value,
      onPressed: onPressed,
      theme: theme,
      child: customChild,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? NumpadTheme.of(context);
    final spacing = widget.spacing ?? theme.spacing;
    final padding = widget.padding ?? theme.numpadPadding;

    return GestureDetector(
      onTap: () {
        // Request focus when tapped
        if (widget.enableKeyboardInput) {
          _focusNode.requestFocus();
        }
      },
      child: Focus(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
        child: Container(
          padding: padding,
          color: theme.backgroundColor,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row 1: 1, 2, 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(context, '1', theme),
                      SizedBox(width: spacing),
                      _buildButton(context, '2', theme),
                      SizedBox(width: spacing),
                      _buildButton(context, '3', theme),
                    ],
                  ),
                  SizedBox(height: spacing),

                  // Row 2: 4, 5, 6
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(context, '4', theme),
                      SizedBox(width: spacing),
                      _buildButton(context, '5', theme),
                      SizedBox(width: spacing),
                      _buildButton(context, '6', theme),
                    ],
                  ),
                  SizedBox(height: spacing),

                  // Row 3: 7, 8, 9
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(context, '7', theme),
                      SizedBox(width: spacing),
                      _buildButton(context, '8', theme),
                      SizedBox(width: spacing),
                      _buildButton(context, '9', theme),
                    ],
                  ),
                  SizedBox(height: spacing),

                  // Row 4: Extra buttons and 0
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Left extra button or spacer
                      if (widget.showLeftExtraButton)
                        _buildButton(
                          context,
                          '',
                          theme,
                          customChild: widget.leftExtraButton,
                          customCallback: widget.onLeftExtraButton,
                        )
                      else
                        SizedBox(width: theme.buttonSize),
                      SizedBox(width: spacing),

                      // 0 button
                      _buildButton(context, '0', theme),
                      SizedBox(width: spacing),

                      // Right extra button or spacer
                      if (widget.showRightExtraButton)
                        _buildButton(
                          context,
                          '',
                          theme,
                          customChild: widget.rightExtraButton,
                          customCallback: widget.onRightExtraButton,
                        )
                      else
                        SizedBox(width: theme.buttonSize),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

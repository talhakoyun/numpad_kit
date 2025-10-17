import 'package:flutter/material.dart';
import 'numpad_theme.dart';
import 'utils/constants.dart';

/// A button widget used in the numpad.
///
/// This widget handles visual feedback for hover, press, and disabled states.
/// It can display either text or a custom child widget.
///
/// Example:
/// ```dart
/// NumpadButton(
///   value: '5',
///   onPressed: () => print('5 pressed'),
///   theme: NumpadThemeData.light(),
/// )
/// ```
class NumpadButton extends StatefulWidget {
  /// Creates a numpad button.
  const NumpadButton({
    required this.value,
    required this.onPressed,
    required this.theme,
    this.child,
    this.enabled = true,
    super.key,
  });

  /// The value this button represents (typically a digit or symbol).
  final String value;

  /// Callback invoked when the button is pressed.
  final VoidCallback onPressed;

  /// The theme data for this button.
  final NumpadThemeData theme;

  /// Optional custom child widget to display instead of the value text.
  final Widget? child;

  /// Whether this button is enabled.
  final bool enabled;

  @override
  State<NumpadButton> createState() => _NumpadButtonState();
}

class _NumpadButtonState extends State<NumpadButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.theme.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.theme.pressedScale,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.theme.animationCurve,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled) return;
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enabled) return;
    setState(() => _isPressed = false);
    _animationController.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() {
    if (!widget.enabled) return;
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  Color _getButtonColor() {
    if (!widget.enabled) {
      return widget.theme.disabledButtonColor;
    }
    if (_isPressed) {
      return widget.theme.buttonPressedColor;
    }
    if (_isHovered) {
      return widget.theme.buttonHoverColor;
    }
    return widget.theme.buttonColor;
  }

  Color _getTextColor() {
    return widget.enabled
        ? widget.theme.buttonTextColor
        : widget.theme.disabledTextColor;
  }

  BoxDecoration _getDecoration() {
    final color = _getButtonColor();
    final shape = widget.theme.buttonShape;

    BorderRadius? borderRadius;
    if (shape == NumpadButtonShape.circle) {
      borderRadius = BorderRadius.circular(widget.theme.buttonSize / 2);
    } else if (shape == NumpadButtonShape.roundedSquare) {
      borderRadius = BorderRadius.circular(widget.theme.borderRadius);
    }

    return BoxDecoration(
      color: color,
      borderRadius: borderRadius,
      border: widget.theme.borderWidth > 0
          ? Border.all(
              color: widget.theme.buttonBorderColor,
              width: widget.theme.borderWidth,
            )
          : null,
      boxShadow: widget.theme.shadows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.enabled ? (_) => setState(() => _isHovered = true) : null,
      onExit: widget.enabled ? (_) => setState(() => _isHovered = false) : null,
      cursor:
          widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: widget.theme.animationDuration,
            curve: widget.theme.animationCurve,
            width: widget.theme.buttonSize,
            height: widget.theme.buttonSize,
            decoration: _getDecoration(),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.enabled ? widget.onPressed : null,
                borderRadius:
                    widget.theme.buttonShape == NumpadButtonShape.circle
                        ? BorderRadius.circular(widget.theme.buttonSize / 2)
                        : widget.theme.buttonShape ==
                                NumpadButtonShape.roundedSquare
                            ? BorderRadius.circular(widget.theme.borderRadius)
                            : null,
                child: Container(
                  padding: widget.theme.buttonPadding,
                  alignment: Alignment.center,
                  child: widget.child ??
                      Text(
                        widget.value,
                        style: widget.theme.textStyle.copyWith(
                          color: _getTextColor(),
                        ),
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

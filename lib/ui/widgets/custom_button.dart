import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final double borderRadius;
  final List<Color>? gradientColors;
  final double elevation;

  const CustomButton._({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.onPressed,
    this.style,
    required this.borderRadius,
    this.gradientColors,
    this.elevation = 2,
  }) : super(key: key);

  // 1. TEXT BUTTON
  factory CustomButton.text({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    List<Color>? gradientColors,
    Color textColor = Colors.white,
    double? width,
    double? height,
    double borderRadius = 12,
    bool fullWidth = false,
    double elevation = 2,
  }) {
    final hasGradient = gradientColors != null && gradientColors.isNotEmpty;
    final bgColor = backgroundColor ?? Colors.green;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: hasGradient ? Colors.transparent : bgColor,
      foregroundColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: hasGradient ? 0 : elevation,
      shadowColor: hasGradient ? Colors.transparent : null,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    );

    return CustomButton._(
      width: fullWidth ? double.infinity : width,
      height: height ?? 50,
      onPressed: onPressed,
      borderRadius: borderRadius,
      style: buttonStyle,
      gradientColors: hasGradient ? gradientColors : null,
      elevation: elevation,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // 2. ICON + TEXT BUTTON
  factory CustomButton.iconText({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    Color? backgroundColor,
    List<Color>? gradientColors,
    Color? iconColor,
    Color? textColor,
    double? width,
    double? height,
    double borderRadius = 12,
    bool fullWidth = false,
    bool iconLeft = true,
    double iconSize = 20,
    double spacing = 8,
    double elevation = 2,
  }) {
    final hasGradient = gradientColors != null && gradientColors.isNotEmpty;
    final bgColor = backgroundColor ?? Colors.blue;
    final txtColor = textColor ?? Colors.white;
    final icoColor = iconColor ?? txtColor;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: hasGradient ? Colors.transparent : bgColor,
      foregroundColor: txtColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: hasGradient ? 0 : elevation,
      shadowColor: hasGradient ? Colors.transparent : null,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    );

    final children = iconLeft
        ? [
            Icon(icon, color: icoColor, size: iconSize),
            SizedBox(width: spacing),
            Text(
              text,
              style: TextStyle(
                color: txtColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ]
        : [
            Text(
              text,
              style: TextStyle(
                color: txtColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: spacing),
            Icon(icon, color: icoColor, size: iconSize),
          ];

    return CustomButton._(
      width: fullWidth ? double.infinity : width,
      height: height ?? 50,
      onPressed: onPressed,
      borderRadius: borderRadius,
      style: buttonStyle,
      gradientColors: hasGradient ? gradientColors : null,
      elevation: elevation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  // 3. ICON ONLY BUTTON
  factory CustomButton.iconOnly({
    required IconData icon,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.grey,
    Color iconColor = Colors.white,
    double size = 40,
    double borderRadius = 8,
    bool circular = false,
    double elevation = 2,
  }) {
    final effectiveBorderRadius = circular ? size / 2 : borderRadius;

    return CustomButton._(
      width: size,
      height: size,
      onPressed: onPressed,
      borderRadius: effectiveBorderRadius,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: iconColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
        ),
        elevation: elevation,
        padding: EdgeInsets.zero,
      ),
      child: Icon(icon, color: iconColor, size: size * 0.6),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasGradient = gradientColors != null && gradientColors!.isNotEmpty;

    final button = SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(onPressed: onPressed, style: style, child: child),
    );

    // For gradient, wrap button in gradient container
    if (hasGradient) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors!,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: elevation * 2,
              offset: Offset(0, elevation),
            ),
          ],
        ),
        child: button,
      );
    }

    return button;
  }
}

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;

  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = color ?? Theme.of(context).colorScheme.primary;

    // text color if not provided
    final fgColor = textColor ?? _getContrastingTextColor(bgColor);

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold, color: fgColor, fontSize: 14)),
      ),
    );
  }

  // Helps text stay readable on any background
  Color _getContrastingTextColor(Color bgColor) {
    return bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

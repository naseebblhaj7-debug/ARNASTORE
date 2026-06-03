import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double? width;
  final double? height;
  final FontWeight fontWeight;
  final IconData? icon;
  final bool enabled;
  final double elevation;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 16,
    this.padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
    this.borderRadius = 18,
    this.width,
    this.height,
    this.fontWeight = FontWeight.w600,
    this.icon,
    this.enabled = true,
    this.elevation = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor ?? AppColors.buttonBackground,

          foregroundColor: textColor ?? AppColors.buttonText,

          disabledBackgroundColor: Colors.grey.shade300,

          padding: padding,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: fontSize + 2,
                color: textColor ?? AppColors.buttonText,
              ),
              const SizedBox(width: 8),
            ],

            Text(
              text,
              style: TextStyle(
                color: textColor ?? AppColors.buttonText,
                fontSize: fontSize,
                fontWeight: fontWeight,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

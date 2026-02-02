import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/constants/fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    this.borderColor,
    this.onTap,
    this.color = AppColors.primary,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.elevation = 0,
    this.textPadding,
    this.textStyle,
    super.key,
  });

  final VoidCallback? onTap;
  final String text;
  final Color? borderColor;
  final Color color;
  final double? height;
  final double? width;
  final BorderRadius borderRadius;
  final double elevation;
  final EdgeInsetsGeometry? textPadding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Responsive text size
    double responsiveFontSize;
    EdgeInsetsGeometry responsivePadding;

    if (screenWidth < 480) {
      responsiveFontSize = 8;
      responsivePadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16);
    } else if (screenWidth < 800) {
      responsiveFontSize = 10;
      responsivePadding = const EdgeInsets.symmetric(vertical: 12, horizontal: 20);
    } else if (screenWidth < 1200) {
      responsiveFontSize = 12;
      responsivePadding = const EdgeInsets.symmetric(vertical: 14, horizontal: 24);
    } else {
      responsiveFontSize = 14;
      responsivePadding = const EdgeInsets.symmetric(vertical: 16, horizontal: 28);
    }

    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      child: InkWell(
        splashColor: Colors.black12,
        borderRadius: borderRadius,
        onTap: onTap,
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            border: borderColor != null ? Border.all(color: borderColor!, width: 1) : null,
          ),
          child: Padding(
            padding: textPadding ?? responsivePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: textStyle ??
                      TextStyle(
                        fontSize: responsiveFontSize,
                        color: Colors.white,
                        fontFamily: AppFont.montserratBold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

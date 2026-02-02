// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String hintText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final Function()? onTap;
  final String? initialValue;
  final bool readOnly;
  final Color fillColor;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final VoidCallback? onEditComplete;
  final int maxLines;
  final int? minLines;
  final TextInputType keyboardType;
  final bool enableBorder; 

  const CustomTextField({
    super.key,
    required this.name,
    required this.hintText,
    required this.enableBorder,
    this.onEditComplete,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.validator,
    this.initialValue,
    this.textInputAction = TextInputAction.done,
    this.onTap,
    required this.fillColor,
    this.readOnly = false,
    this.keyboardType = TextInputType.name,
    this.maxLines = 1,
    this.minLines,
  });

  @override
Widget build(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;

  // Set breakpoints and scale factors
  double fieldWidth;
  double fontSize;
  double paddingSize;

  if (screenWidth < 480) {
    // Small mobile
    fieldWidth = screenWidth * 0.95;
    fontSize = 12;
    paddingSize = 12;
  } else if (screenWidth < 800) {
    // Tablets / large phones
    fieldWidth = screenWidth * 0.85;
    fontSize = 14;
    paddingSize = 14;
  } else if (screenWidth < 1200) {
    // Small desktops / tablets
    fieldWidth = screenWidth * 0.6;
    fontSize = 16;
    paddingSize = 16;
  } else {
    // Large desktop
    fieldWidth = 600;
    fontSize = 18;
    paddingSize = 18;
  }

  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: fieldWidth),
      child: FormBuilderTextField(
        textInputAction: textInputAction,
        validator: validator,
        controller: controller,
        onEditingComplete: onEditComplete,
        onChanged: onChanged,
        onTap: onTap,
        name: name,
        readOnly: readOnly,
        initialValue: initialValue,
        style: TextStyle(fontSize: fontSize), // ⬅️ Responsive font size
        cursorColor: AppColors.grey,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(paddingSize), // ⬅️ Responsive padding
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: fontSize * 0.9,
            color: AppColors.darkGrey.withOpacity(0.5),
            letterSpacing: 1,
          ),
          fillColor: fillColor,
          filled: true,
          enabled: true,
          enabledBorder:
              enableBorder ? AppColors.enableBorder : InputBorder.none,
          focusedBorder:
              enableBorder ? AppColors.kFocuseBorder : InputBorder.none,
          errorBorder: AppColors.kErrorOutlineBorder,
          focusedErrorBorder: AppColors.kErrorOutlineBorder,
        ),
      ),
    ),
  );
}
}
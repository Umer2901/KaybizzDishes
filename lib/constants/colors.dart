import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppColors {
  static const Color primary = Colors.orange;
  static const Color grey = Color(0xffD8DADC);
  static const Color maroon = Color(0xff4A2222);
  static const Color darkGrey = Color(0xff333333);
  static const Color blue = Color(0xFFA3AED0);
  static const Color navyBlue = Color(0xFF2B3674);
  static const Color lightBlue = Color(0xFFF0F9FF);
  static const Color red = Color(0xFFDB3022);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color green = Color(0xFF05DEA7);
  static const Color backgroundColor = Color(0xFFF4F7FE);



  static final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.sp),
    borderSide: const BorderSide(
      color: Color(0xFFD8DADC),
    ),
  );
  

  static final kFocuseBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.sp),
    borderSide: const BorderSide(
      color: Color(0xFF000000),
    ),
  );

  static final kErrorOutlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.sp),
    borderSide: const BorderSide(
      color: Colors.red,
    ),
  );
}
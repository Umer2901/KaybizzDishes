// ignore_for_file: sized_box_for_whitespace

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/constants/images.dart';
import 'package:flutter_application_kaybizz/widgets/custom_appbar.dart';
import 'package:flutter_application_kaybizz/widgets/custom_footer.dart';
import 'package:sizer/sizer.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 229, 230),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;

            // Responsive font sizes with max caps
            double headingFont = min(
                screenWidth < 600 ? 10.sp : screenWidth / 30, 48); // max 48px
            double bodyFont = min(
                screenWidth < 600 ? 8.sp : screenWidth / 60, 20); // max 20px

            // Responsive layout: horizontal on large, vertical on small
            bool isMobile = screenWidth < 800;

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                 //     Center(child: CalendarMegaTabs()),
                
                      SizedBox(height: 3.h),
                
                      Divider(thickness: 0.5, color: AppColors.primary),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          "About Us",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Divider(thickness: 0.5, color: AppColors.primary),
                
                      SizedBox(height: 3.h),
                
                      // Responsive row/column for image + text
                      isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(AppImages.shop,
                                    width: 80.w, fit: BoxFit.cover),
                                SizedBox(height: 2.h),
                                Text(
                                  "Welcome to EasyPrint",
                                  style: TextStyle(
                                      fontSize: headingFont, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  '''Here at EasyPrint we like to describe ourselves as an easy-to-use local print destination that puts the power back in your hands. With papers and finishes to suit your designs — because print shouldn’t be one size fits all. We're a well-established printing company in the UK without a shadow of doubt produces best value, highest specification printing from one to full colour. We have a full in-house printing service operated by a team of professionals, capable of meeting the high standards that are required in order to satisfy every area in the printing business.''',
                                  style: TextStyle(fontSize: bodyFont, height: 1.6),
                                ),
                                   SizedBox(height: 2.h),
                                         Text(
                                        "Our Specialization",
                                        style: TextStyle(
                                            fontSize: headingFont, 
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        '''- All Kind of Large Formats \n- Any Kind of Personalized Gift Items \n- Any size of Print & Copy \n- Any Stationary Item ''',
                                        style: TextStyle(fontSize: bodyFont, height: 1.6),
                                      ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: 50.h,
                                    width: 70.w,
                                    child: Image.asset(AppImages.shop, fit: BoxFit.cover)),
                                ),
                                SizedBox(width: 4.w),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Welcome to EasyPrint",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        '''Here at EasyPrint we like to describe ourselves as an easy-to-use local print destination that puts the power back in your hands. With papers and finishes to suit your designs — because print shouldn’t be one size fits all. We're a well-established printing company in the UK without a shadow of doubt produces best value, highest specification printing from one to full colour. We have a full in-house printing service operated by a team of professionals, capable of meeting the high standards that are required in order to satisfy every area in the printing business.''',
                                        style: TextStyle(fontSize: 16, height: 1.6),
                                      ),
                                        SizedBox(height: 2.h),
                                         Text(
                                        "Our Specialization",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        '''- All Kind of Large Formats \n- Any Kind of Personalized Gift Items \n- Any size of Print & Copy \n- Any Stationary Item ''',
                                        style: TextStyle(fontSize: 16, height: 1.6),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            
                    ],
                  ),
                ),
                   Container(
      // width: double.infinity,
      color: AppColors.white,
      child: Column(
        children: [
          FooterWidget(),
        ],
      ),
    ),
    Container(
      height: 4.h,
      width: double.infinity,
      color: AppColors.primary,
      child: Center(child: Text("EasyPrint - Copyright © 2024 easyprint.london. All Rights Reserved. Designed by EasyPrint Devs",style: TextStyle(fontSize: 10,color: AppColors.white),)),
    )
              ],
            );
            
          },
        ),
      ),
    );
  }
}

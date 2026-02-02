// ignore_for_file: use_super_parameters, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/constants/images.dart';
import 'package:flutter_application_kaybizz/home.dart';
import 'package:flutter_application_kaybizz/widgets/custom_buttons.dart';
import 'package:flutter_application_kaybizz/widgets/custom_mega.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight + 28), 
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
    automaticallyImplyLeading: false,
      backgroundColor: AppColors.black,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                               Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
                            },
                            child: Container(
                              height: 10.h,
                              child: Image.asset(AppImages.logo, fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                    
                 Center(child: CalendarMegaTabs()),
                 SizedBox(width: 3.w),

                 CustomButton(text: "Order Now",onTap: () 
                   async {
          final Uri whatsappUri = Uri.parse("https://wa.me/447404087369");
          if (await canLaunchUrl(whatsappUri)) {
            await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Could not open WhatsApp."),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
                 )
                     
                      ],
                    ),
                   
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/constants/images.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  final List<Map<String, List<String>>> footerSections = [
 
    {
      'Contact us': [
        'Address: Shop 219, Rye Lane London SE15 4TP.',
        'Email: contact@kaybizzdishes.com',
        'Phone: +44 740 408 7369',
      ]
    },
   
    {
      'opening time': [
        ' Your local dining spot is opened whenever you need us',
        'Breakfast Special. . . . . 8:00 AM - 11:00 PM',
        'Lunch Special. . . . . . . . . . . . 12:00 PM - 5:30 PM',
        'Dinner Special. . . . . . . . . . . . 06:00 PM - 09:00 PM',
      ]
    },
  ];

  // ✅ Social icons with their links
  final List<Map<String, dynamic>> socialLinks = [
    {
      'icon': Icons.facebook,
      'url': 'https://www.facebook.com/EasyPrintUK',
    },
    {
      'icon': Icons.camera_alt, 
      'url': 'https://www.instagram.com/easyprint88/',
    },
    {
      'icon': Icons.call,
      'url': 'https://wa.me/447402171149',
    },
    {
      'icon': Icons.email,
      'url': 'mailto:easyprint33@gmail.com', 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          // Top section: Columns with links
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: footerSections.map((section) {
                String title = section.keys.first;
                List<String> items = section.values.first;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...items.map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              item,
                              style: const TextStyle(
                                   color: AppColors.primary,
                                fontSize: 12,

                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 28),

          // Middle section: Logo and social icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo on left
              Image.asset(
                AppImages.logo,
                height: 15.h,
                width: 15.w,
              ),

              // ✅ Social Icons on right
              Row(
                children: socialLinks.map((item) {
                  return GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse(item['url']);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade200,
                        child: Icon(
                          item['icon'],
                          size: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

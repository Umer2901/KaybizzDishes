// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, use_build_context_synchronously
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/constants/images.dart';
import 'package:flutter_application_kaybizz/widgets/custom_appbar.dart';
import 'package:flutter_application_kaybizz/widgets/custom_banner.dart';
import 'package:flutter_application_kaybizz/widgets/custom_banner3.dart';
import 'package:flutter_application_kaybizz/widgets/custom_event_card.dart';
import 'package:flutter_application_kaybizz/widgets/custom_foodmenu.dart';
import 'package:flutter_application_kaybizz/widgets/custom_footer.dart';
import 'package:flutter_application_kaybizz/widgets/custom_herobanner2.dart';
import 'package:flutter_application_kaybizz/widgets/custom_video.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final Color orange = Colors.deepOrangeAccent;
  final Color white = Colors.white;
  final Color bg = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: CustomAppBar(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeroBannerPro(
             // image: AssetImage(AppImages.food1),
              title: 'Welcome to\nKaybizzDishes',
              subtitle:
                  'Experience the true flavors of Africa dishes from our restaurant, crafted with love and passion. Every bite of our meal tells a story of our rich culture and tradition.\nPatronise us TODAY!!!',
              buttonLabel: 'Order Now',
              onButtonPressed: ()  async {
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
              overlayColor: Colors.black.withOpacity(0.55),
              tabletHeight: 520,
              desktopHeight: 680,
            ),
            SizedBox(height: 10.h),

            // About Section
            LayoutBuilder(
              builder: (context, c) {
                final double w = c.maxWidth;
                final bool isMobile = w < 600;
                final bool isTablet = w >= 600 && w < 1024;
                final bool isCompact = isMobile || isTablet;

                // IMAGE
                Widget image;
               if (isCompact) {
  image = ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: AspectRatio(
      aspectRatio: 16 / 9,
      child: SilentVideo(
        assetPath: "assets/video/food.mp4",
      ),
    ),
  );
} else {
  image = Container(
    height: 70.h,
    width: 50.w,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    child: SilentVideo(
      assetPath: "assets/video/food.mp4",
    ),
  );


                }

                final Widget textContent = Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About KayBizzDishes',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'KayBizzDishes, continually bringing the taste of Africa to your table.',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                          color: white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'We were born from a passion for the authentic flavors of Africa and a desire to share this passion with you. Every dish we prepare is a tribute to the richness and diversity of African cuisine. We use only fresh ingredients in preparing our meals. Come discover a unique culinary experience, where you can savor the aromas and flavors of Africa in the heart of Peckham.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                );

                if (isCompact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      image,
                      const SizedBox(height: 16),
                      textContent,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    image,
                    const SizedBox(width: 24),
                    Expanded(child: textContent),
                  ],
                );
              },
            ),

            SizedBox(height: 8.h),

            // Section Title Widget
            sectionHeader(
              title: "Our Special Dishes",
              description:
                  "Our special dishes are a testament to the rich culinary heritage of Africa. Each creation is a carefully crafted blend of traditional flavors and modern techniques. From the fiery heat of our Pepper Soup to the delicate sweetness of our Jollof Rice, every dish is a journey through the diverse landscapes and cultures of the continent.",
            ),

            SizedBox(height: 2.h),

            HeroBanner2(
           //   image: AssetImage(AppImages.food3),
            ),

            SizedBox(height: 3.h),

            sectionHeader(
              title: "Our Food Menu",
              description:
                  "Savor the extraordinary: Our curated selection of African delicacies. From traditional favorites to innovative creations, each dish is a masterpiece of flavor and technique. Indulge in the bold and exotic tastes of our special menu and experience the true essence of African cuisine.",
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: FoodMenuSection()),
            ),

            SizedBox(height: 3.h),

            sectionHeader(
              title: "Our Gallery",
              description:
                  "Step into our world: A visual journey through the heart of Africa. Explore our vibrant gallery and experience the warmth of our atmosphere, the artistry of our cuisine, and the passion of our people. From behind-the-scenes glimpses of our kitchen to stunning images of our dishes and dining experience, our gallery captures the essence of our restaurant. Join us on this visual adventure and discover the magic of African hospitality.",
            ),
            SizedBox(height: 2.h),
HeroBanner3(
 //image: AssetImage(AppImages.food3), 
),

            SizedBox(height: 5.h),
            Container(
              width: double.infinity,
              color: bg,
              child: Column(
                children: [
                  FooterWidget(),
                ],
              ),
            ),
            Container(
              height: 4.h,
              width: double.infinity,
              color: orange,
              child: Center(
                child: Text(
                  "KAYBIZZ - Copyright © 2024  All Rights Reserved",
                  style: TextStyle(fontSize: 10, color: bg),
                ),
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () async {
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
        child: SizedBox(
          width: 40.w,
          height: 40.h,
          child: Image.asset(
            AppImages.whatsapp,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }

  /// Helper to build each section with consistent colors and layout
  Widget sectionHeader({required String title, required String description}) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'GreatVibes',
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 40, height: 1, color: AppColors.primary),
              const SizedBox(width: 8),
              const Icon(Icons.restaurant_menu,
                 color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Container(width: 40, height: 1, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[200],
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

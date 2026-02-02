// import 'package:flutter/material.dart';
// import 'package:flutter_application_kaybizz/constants/colors.dart';
// import 'package:flutter_application_kaybizz/widgets/custom_appbar.dart';
// import 'package:flutter_application_kaybizz/widgets/custom_footer.dart';
// import 'package:sizer/sizer.dart';

// class Menu extends StatelessWidget {
//   const Menu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bool isMobile = MediaQuery.of(context).size.width < 800;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 229, 229, 230),
//       appBar: CustomAppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: isMobile ? 5.w : 10.w,
//                 vertical: 2.h,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 3.h),
//                   Divider(thickness: 0.5, color: AppColors.primary),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 1.h),
//                     child: Text(
//                       "Menu",
//                       style: TextStyle(
//                         fontSize: isMobile ? 18 : 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   Divider(thickness: 0.5, color: AppColors.primary),
//                   SizedBox(height: 3.h),

//                   // Responsive layout for showing images (menu1 to menu5)
//                   isMobile
//                       ? Column(
//                           children: [
//                             Image.asset(
//                               'assets/images/menu1.jpg',
//                               height: 50.h, // Increase height for bigger image
//                               width: double.infinity,
//                               fit: BoxFit.contain, // Keep aspect ratio
//                             ),
//                             SizedBox(height: 3.h),
//                             Image.asset(
//                               'assets/images/menu2.jpg',
//                               height: 50.h,
//                               width: double.infinity,
//                               fit: BoxFit.contain,
//                             ),
//                             SizedBox(height: 3.h),
//                             Image.asset(
//                               'assets/images/menu3.jpg',
//                               height: 50.h,
//                               width: double.infinity,
//                               fit: BoxFit.contain,
//                             ),
//                             SizedBox(height: 3.h),
//                             Image.asset(
//                               'assets/images/menu4.jpg',
//                               height: 50.h,
//                               width: double.infinity,
//                               fit: BoxFit.contain,
//                             ),
//                             SizedBox(height: 3.h),
//                             Image.asset(
//                               'assets/images/menu5.jpg',
//                               height: 50.h,
//                               width: double.infinity,
//                               fit: BoxFit.contain,
//                             ),
//                           ],
//                         )
//                       : Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Flexible(
//                                   child: Image.asset(
//                                     'assets/images/menu1.jpg',
//                                     height: 60.h, // Larger image size
//                                     width: double.infinity,
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                                 SizedBox(width: 4.w),
//                                 Flexible(
//                                   child: Image.asset(
//                                     'assets/images/menu2.jpg',
//                                     height: 60.h,
//                                     width: double.infinity,
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 4.h),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Flexible(
//                                   child: Image.asset(
//                                     'assets/images/menu3.jpg',
//                                     height: 60.h,
//                                     width: double.infinity,
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                                 SizedBox(width: 4.w),
//                                 Flexible(
//                                   child: Image.asset(
//                                     'assets/images/menu4.jpg',
//                                     height: 60.h,
//                                     width: double.infinity,
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 4.h),
//                             Image.asset(
//                               'assets/images/menu5.jpg',
//                               height: 60.h,
//                               width: double.infinity,
//                               fit: BoxFit.contain,
//                             ),
//                           ],
//                         ),

//                   SizedBox(height: 5.h),
//                 ],
//               ),
//             ),

//             /// Footer
//             Container(
//               color: AppColors.white,
//               child: FooterWidget(),
//             ),
//             Container(
//               height: 4.h,
//               width: double.infinity,
//               color: AppColors.primary,
//               child: const Center(
//                 child: Text(
//                   "KaybizzDishes © 2024. All Rights Reserved. Designed by Umer Devs",
//                   style: TextStyle(fontSize: 10, color: AppColors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/widgets/custom_appbar.dart';
import 'package:flutter_application_kaybizz/widgets/custom_footer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  // Function to navigate to the full screen view of the image
  void _openImage(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageView(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery for responsive design
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;  // Mobile: <600
    final bool isTablet = screenWidth >= 600 && screenWidth < 1200;  // Tablet: 600-1200
    final bool isWeb = screenWidth >= 1200;  // Web: >1200

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 229, 230),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Your HeroBannerPro widget code here (removed for brevity)
            
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 5.w : (isTablet ? 8.w : 10.w),
                vertical: 2.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  
                  // Images section with Wrap widget for better responsiveness
                  isMobile
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () => _openImage(context, 'assets/images/menu1.jpg'),
                              child: Image.asset(
                                'assets/images/menu1.jpg',
                                height: 40.h,  // Adjust for mobile view
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            GestureDetector(
                              onTap: () => _openImage(context, 'assets/images/menu2.jpg'),
                              child: Image.asset(
                                'assets/images/menu2.jpg',
                                height: 40.h,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            GestureDetector(
                              onTap: () => _openImage(context, 'assets/images/menu3.jpg'),
                              child: Image.asset(
                                'assets/images/menu3.jpg',
                                height: 40.h,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            GestureDetector(
                              onTap: () => _openImage(context, 'assets/images/menu4.jpg'),
                              child: Image.asset(
                                'assets/images/menu4.jpg',
                                height: 40.h,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            GestureDetector(
                              onTap: () => _openImage(context, 'assets/images/menu5.jpg'),
                              child: Image.asset(
                                'assets/images/menu5.jpg',
                                height: 40.h,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        )
                      : isTablet
                          ? Wrap(
                              spacing: 4.w,  // Space between images horizontally
                              runSpacing: 4.h,  // Space between rows
                              children: [
                                GestureDetector(
                                  onTap: () => _openImage(context, 'assets/images/menu1.jpg'),
                                  child: Container(
                                    width: (screenWidth - 8.w) / 2,  // Set width for each image
                                    child: Image.asset(
                                      'assets/images/menu1.jpg',
                                      height: 45.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _openImage(context, 'assets/images/menu2.jpg'),
                                  child: Container(
                                    width: (screenWidth - 8.w) / 2,
                                    child: Image.asset(
                                      'assets/images/menu2.jpg',
                                      height: 45.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _openImage(context, 'assets/images/menu3.jpg'),
                                  child: Container(
                                    width: (screenWidth - 8.w) / 2,
                                    child: Image.asset(
                                      'assets/images/menu3.jpg',
                                      height: 45.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _openImage(context, 'assets/images/menu4.jpg'),
                                  child: Container(
                                    width: (screenWidth - 8.w) / 2,
                                    child: Image.asset(
                                      'assets/images/menu4.jpg',
                                      height: 45.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _openImage(context, 'assets/images/menu5.jpg'),
                                  child: Container(
                                    width: double.infinity,
                                    child: Image.asset(
                                      'assets/images/menu5.jpg',
                                      height: 45.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : isWeb
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // Three-column layout for web
                                    crossAxisSpacing: 4.w,
                                    mainAxisSpacing: 4.h,
                                  ),
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    String imageName = 'menu${index + 1}.jpg';
                                    return GestureDetector(
                                      onTap: () => _openImage(context, 'assets/images/$imageName'),
                                      child: Container(
                                        width: double.infinity,  // Constrain width to available space
                                        child: Image.asset(
                                          'assets/images/$imageName',
                                          height: 45.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(), // Default to empty container for unknown cases

                  SizedBox(height: 5.h),
                ],
              ),
            ),

            /// Footer
            Container(
              color: AppColors.white,
              child: FooterWidget(),
            ),
            Container(
              height: 4.h,
              width: double.infinity,
              color: AppColors.primary,
              child: const Center(
                child: Text(
                  "KaybizzDishes © 2024. All Rights Reserved.",
                  style: TextStyle(fontSize: 10, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Full Screen Image View Screen
class FullScreenImageView extends StatelessWidget {
  final String imagePath;

  const FullScreenImageView({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Close the image view on tap
          },
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}

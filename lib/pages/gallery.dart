// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class FirebaseGallery extends StatefulWidget {
//   const FirebaseGallery({super.key});

//   @override
//   State<FirebaseGallery> createState() => _FirebaseGalleryState();
// }

// class _FirebaseGalleryState extends State<FirebaseGallery> {
//   /// Fetch from Firestore and group by 'type'
//   Future<Map<String, List<String>>> fetchGallery() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection("gallery")
//         .orderBy("type")
//         .get();

//     /// Grouped by type
//     Map<String, List<String>> grouped = {};

//     for (var doc in snapshot.docs) {
//       String type = doc["type"] ?? "Unknown";
//       String imageUrl = doc["imageUrl"];

//       if (!grouped.containsKey(type)) {
//         grouped[type] = [];
//       }
//       grouped[type]!.add(imageUrl);
//     }

//     return grouped;
//   }

//   /// Fullscreen viewer
//   void openFullScreen(List<String> images, int index) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => _FullScreenImageViewer(
//           images: images,
//           initialIndex: index,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, List<String>>>(
//       future: fetchGallery(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Padding(
//             padding: EdgeInsets.all(40),
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         final gallery = snapshot.data!;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: gallery.entries.map((entry) {
//             String typeName = entry.key;
//             List<String> images = entry.value;

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),

//                 /// ⭐ TYPE NAME HEADER
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(
//                     typeName,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 12),

//                 /// ⭐ GRID OF IMAGES
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: images.length,
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () => openFullScreen(images, index),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.network(
//                             images[index],
//                             fit: BoxFit.cover,
//                             loadingBuilder: (context, child, event) {
//                               if (event == null) return child;
//                               return Container(color: Colors.grey.shade300);
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 25),
//               ],
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// //////////////////////////////////////////////////////////////////
// // ⬇️ SINGLE FULL-SCREEN VIEWER INSIDE SAME FILE
// //////////////////////////////////////////////////////////////////

// class _FullScreenImageViewer extends StatefulWidget {
//   final List<String> images;
//   final int initialIndex;

//   const _FullScreenImageViewer({
//     required this.images,
//     required this.initialIndex,
//   });

//   @override
//   State<_FullScreenImageViewer> createState() =>
//       __FullScreenImageViewerState();
// }

// class __FullScreenImageViewerState extends State<_FullScreenImageViewer> {
//   late PageController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = PageController(initialPage: widget.initialIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black87,
//         elevation: 0,
//       ),
//       body: PageView.builder(
//         controller: controller,
//         itemCount: widget.images.length,
//         itemBuilder: (context, index) {
//           return InteractiveViewer(
//             child: Center(
//               child: Image.network(
//                 widget.images[index],
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/constants/images.dart';
import 'package:flutter_application_kaybizz/widgets/custom_appbar.dart';
import 'package:flutter_application_kaybizz/widgets/custom_banner.dart';
import 'package:sizer/sizer.dart';

class FirebaseGallery extends StatefulWidget {
  const FirebaseGallery({super.key});

  @override
  State<FirebaseGallery> createState() => _FirebaseGalleryState();
}

class _FirebaseGalleryState extends State<FirebaseGallery> {
  /// Fetch images from Firestore and group by 'type'
  Future<Map<String, List<Uint8List>>> fetchGallery() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("gallery")
        .orderBy("type")
        .get();

    Map<String, List<Uint8List>> grouped = {};

    for (var doc in snapshot.docs) {
      String type = doc["type"] ?? "Unknown";
      String base64Image = doc["imageData"];

      Uint8List imageBytes = base64Decode(base64Image);

      grouped.putIfAbsent(type, () => []);
      grouped[type]!.add(imageBytes);
    }

    return grouped;
  }

  /// Fullscreen viewer
  void openFullScreen(List<Uint8List> images, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullScreenImageViewer(
          images: images,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ⭐ ADDING THE HERO BANNER YOU PROVIDED
            HeroBannerPro(
             // image: AssetImage(AppImages.food1),
              title: 'Check The Gallery Of\nKaybizzDishes',
              subtitle:
                  'Experience the true flavors of Africa dishes from our restaurant, crafted with love and passion. Every bite of our meal tells a story of our rich culture and tradition.\nPatronise us TODAY!!!',
              //buttonLabel: 'Order Now',
              onButtonPressed: () {},
              overlayColor: Colors.black.withOpacity(0.55),
              tabletHeight: 520,
              desktopHeight: 680,
            ),

            SizedBox(height: 5.h),

            /// ⭐ FIREBASE GALLERY CONTENT
            FutureBuilder<Map<String, List<Uint8List>>>(
              future: fetchGallery(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final gallery = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: gallery.entries.map((entry) {
                    String typeName = entry.key;
                    List<Uint8List> images = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        /// ⭐ TYPE NAME
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            typeName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// ⭐ GRID OF IMAGES
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: images.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => openFullScreen(images, index),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 25),
                      ],
                    );
                  }).toList(),
                );
              },
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}

/// FULLSCREEN VIEWER -----------------------------------------------------------

class _FullScreenImageViewer extends StatefulWidget {
  final List<Uint8List> images;
  final int initialIndex;

  const _FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImageViewer> createState() => __FullScreenImageViewerState();
}

class __FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: PageView.builder(
        controller: controller,
        itemCount: widget.images.length,
        itemBuilder: (_, i) {
          return InteractiveViewer(
            child: Center(
              child: Image.memory(widget.images[i]),
            ),
          );
        },
      ),
    );
  }
}


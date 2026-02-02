import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/gestures.dart';

/// Clean hero/banner with horizontal scrollable 16:9 images only
class HeroBanner3 extends StatefulWidget {
  final ImageProvider? image; // 🔥 NOW OPTIONAL
  final BoxFit fitMobile;
  final BoxFit fitLarger;
  final Color overlayColor;
  final Gradient? gradientOverlay;

  final double? mobileHeight;
  final double mobileAspectRatio;
  final double tabletHeight;
  final double desktopHeight;
  final double mobileBreakpoint;
  final double tabletBreakpoint;

  const HeroBanner3({
    super.key,
    this.image, // 🔥 optional now
    this.fitMobile = BoxFit.fill,
    this.fitLarger = BoxFit.cover,
    this.overlayColor = const Color(0x88000000),
    this.gradientOverlay,
    this.mobileAspectRatio = 16 / 9,
    this.mobileHeight,
    this.tabletHeight = 420,
    this.desktopHeight = 550,
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 1024,
  });

  @override
  State<HeroBanner3> createState() => _HeroBanner3State();
}

class _HeroBanner3State extends State<HeroBanner3> {
  List<Uint8List> images = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadGalleryImages();
  }

  /// 🔥 Fetch ALL images from Firestore collection "gallery"
  Future<void> loadGalleryImages() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("gallery").get();

      images = snapshot.docs.map((doc) {
        String base64Img = doc["imageData"];
        return base64Decode(base64Img);
      }).toList();
    } catch (e) {
      print("ERROR loading gallery: $e");
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final bool isMobile = w < widget.mobileBreakpoint;
        final bool isTablet =
            w >= widget.mobileBreakpoint && w < widget.tabletBreakpoint;

        final double height = isMobile
            ? (widget.mobileHeight ?? (w / widget.mobileAspectRatio))
            : (isTablet ? widget.tabletHeight : widget.desktopHeight);

        return SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// BACKGROUND IMAGE OR FALLBACK COLOR
              if (widget.image != null)
                Image(
                  image: widget.image!,
                  fit: isMobile ? widget.fitMobile : widget.fitLarger,
                )
              else
                Container(
                  color: Colors.black, // Fallback background (customizable)
                ),

              /// OVERLAYS
              if (widget.gradientOverlay != null)
                Container(
                  decoration: BoxDecoration(gradient: widget.gradientOverlay),
                ),
              Container(color: widget.overlayColor),

              /// MAIN CONTENT
              loading
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : images.isEmpty
                      ? const Center(
                          child: Text(
                            "No Images Found",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: isMobile ? 40.h : 42.h,
                            child: ScrollConfiguration(
                              behavior: const ScrollBehavior().copyWith(
                                dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse,
                                },
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: images.map((imgBytes) {
                                    final double cardWidth =
                                        MediaQuery.of(context).size.width < 500
                                            ? MediaQuery.of(context).size.width * 0.85
                                            : 320;

                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: SizedBox(
                                        width: cardWidth,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(14),
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Image.memory(
                                              imgBytes,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        )
            ],
          ),
        );
      },
    );
  }
}

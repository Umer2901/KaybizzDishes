import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_application_kaybizz/widgets/custom_event_card.dart';

/// Banner with horizontal scrollable menu items from "Special Dishes"
class HeroBanner2 extends StatefulWidget {
  final ImageProvider? image; // 🔥 NOW OPTIONAL
  final BoxFit fitMobile;
  final BoxFit fitLarger;
  final Color overlayColor;
  final Gradient? gradientOverlay;

  HeroBanner2({
    super.key,
    this.image, // 🔥 optional now
    this.fitMobile = BoxFit.cover,
    this.fitLarger = BoxFit.cover,
    this.overlayColor = const Color(0x99000000),
    this.gradientOverlay,
  });

  @override
  State<HeroBanner2> createState() => _HeroBanner2State();
}

class _HeroBanner2State extends State<HeroBanner2> {
  List<Map<String, dynamic>> specialItems = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchSpecialDishes();
  }

  /// 🔥 Fetch only SPECIAL DISHES from Firestore
  Future<void> fetchSpecialDishes() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("menu_items")
          .where("category", isEqualTo: "Special Dishes")
          .get();

      specialItems = snapshot.docs.map((doc) {
        String base64Img = doc["image"];
        Uint8List bytes = base64Decode(base64Img);

        return {
          "name": doc["name"],
          "price": doc["price"],
          "bytes": bytes,
        };
      }).toList();
    } catch (e) {
      print("Error loading special dishes: $e");
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 600;
    final isTablet = w >= 600 && w < 1024;
    final double height = isMobile ? w / (16 / 9) : (isTablet ? 420 : 550);

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// 🔹 Background Image (Optional)
          if (widget.image != null)
            Image(
              image: widget.image!,
              fit: isMobile ? widget.fitMobile : widget.fitLarger,
            )
          else
            Container(
              color: Colors.black87, // fallback background
            ),

          /// 🔹 Overlay
          if (widget.gradientOverlay != null)
            Container(decoration: BoxDecoration(gradient: widget.gradientOverlay)),
          Container(color: widget.overlayColor),

          /// 🔹 Special Dishes Scroll
          loading
              ? const Center(child: CircularProgressIndicator())
              : specialItems.isEmpty
                  ? const Center(
                      child: Text(
                        "No Special Dishes Available",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: isMobile ? 45.h : 48.h,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: specialItems.map((item) {
                              final double cardWidth =
                                  w < 500 ? w * 0.8 : 280;

                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: SizedBox(
                                  width: cardWidth,
                                  child: EventCard2(
                                    isAsset: false,
                                    imageBytes: item["bytes"],
                                    title: item["name"],
                                    onTap: () {},
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}

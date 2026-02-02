import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/widgets/custom_buttons.dart';

class EventCard extends StatelessWidget {
  final String imageUrl;
  final bool isAsset; // ✅ Added this flag
  final String date;
  final String title;
  final VoidCallback onTap;

  const EventCard({
    Key? key,
    required this.imageUrl,
    this.isAsset = false, 
    required this.date,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Handle both asset and network images
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: isAsset
                ? Image.asset(
                    imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date
                Text(
                  date,
                  style: const TextStyle(color: Colors.orange, fontSize: 13),
                ),
                const SizedBox(height: 5),

                // Title
              Text(
  title,
  maxLines: 1, // 
  overflow: TextOverflow.ellipsis,
  style: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
),

                const SizedBox(height: 12),

                // Button
               
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventCard2 extends StatelessWidget {
  final String? imageUrl;
  final Uint8List? imageBytes;
  final bool isAsset;
  final String title;
  final VoidCallback onTap;

  const EventCard2({
    Key? key,
    this.imageUrl,
    this.imageBytes,
    this.isAsset = false,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // IMAGE WIDGET
    Widget imageWidget;
    if (imageBytes != null) {
      imageWidget = Image.memory(imageBytes!, fit: BoxFit.cover);
    } else if (isAsset) {
      imageWidget = Image.asset(imageUrl!, fit: BoxFit.cover);
    } else {
      imageWidget = Image.network(imageUrl!, fit: BoxFit.cover);
    }

    return InkWell(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 16 / 9, // ⭐ FULL 16:9 CARD
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [

              /// 🔹 FULL BACKGROUND IMAGE
              imageWidget,

              /// 🔹 GRADIENT AT BOTTOM FOR TEXT READABILITY
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.65),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

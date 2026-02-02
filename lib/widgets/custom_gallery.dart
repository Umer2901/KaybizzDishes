import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/widgets/custom_buttons.dart';

class EventCard2 extends StatelessWidget {
  final String imageUrl;
  final bool isAsset; // ✅ Asset vs network
  final String date;
  final String title;
  final VoidCallback onTap;

  const EventCard2({
    Key? key,
    required this.imageUrl,
    this.isAsset = false,
    required this.date,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // 🔹 Responsive card width
    final double cardWidth = screenWidth < 500
        ? screenWidth * 0.8       // 80% width on small devices
        : (screenWidth < 900
            ? 320                 // medium devices
            : 360);               // larger screens

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 16:9 Responsive Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9, // ⭐ Keeps image 16:9
                child: isAsset
                    ? Image.asset(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            // 🔹 Text content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date / price / label
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Title (ellipsis on overflow)
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // You can put a button here if needed
                  // CustomButton(
                  //   text: "View Details",
                  //   onPressed: onTap,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

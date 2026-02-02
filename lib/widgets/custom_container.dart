import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final String imageUrl;
  final String text;

  ResponsiveContainer({required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    // Get the device screen size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Adjust the container width and height based on screen size
    double containerWidth = width * 0.8; // 80% of screen width
    double imageHeight = width > 600 ? 200 : 150; // Larger image on larger screens

    return Container(
      width: containerWidth,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blueAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            width: containerWidth,
            height: imageHeight,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: width > 600 ? 24 : 16, // Larger text on larger screens
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
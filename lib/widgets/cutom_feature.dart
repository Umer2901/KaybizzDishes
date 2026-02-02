// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({super.key});

  final List<_FeatureItem> features = const [
    _FeatureItem(
      icon: Icons.thumb_up_alt_outlined,
      title: "Print Quality",
      description:
          "Bright inks. Thick Paper Stock. Precise cuts.\nWe believe that quality printing matters.",
      buttonText: "PLACE AN ORDER",
    ),
    _FeatureItem(
      icon: Icons.schedule_outlined,
      title: "Timely Delivery",
      description:
          "No printer is faster. Order today by 6:00pm\nand you can get it tomorrow for small runs.",
      buttonText: "PLACE AN ORDER",
    ),
    _FeatureItem(
      icon: Icons.design_services_outlined,
      title: "Great Design",
      description:
          "Our design team is regularly updated with\nthe best practices. Adobe Certified too.",
      buttonText: "ORDER NOW",
    ),
    _FeatureItem(
      icon: Icons.attach_money_outlined,
      title: "Value for money",
      description:
          "Our products are of great quality, yet\naffordable. We work hard to keep them that way.",
      buttonText: "ORDER NOW",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFFE9E9EA),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: isMobile ? 5.w : 10.w),
      child: Column(
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: features.map((feature) {
              return _FeatureCard(item: feature, isMobile: isMobile);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem item;
  final bool isMobile;

  const _FeatureCard({required this.item, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? 100.w : 22.w,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            spreadRadius: 2,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(item.icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 16),
          Text(
            item.title,
            style: TextStyle(
              fontSize: isMobile ? 14.sp : 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            item.description,
            style: TextStyle(
              fontSize: isMobile ? 10.sp : 12,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
             onPressed: () async{
    final Uri whatsappUri = Uri.parse("https://wa.me/447402171149");

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
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.lightBlueAccent,
              side: const BorderSide(color: Colors.lightBlueAccent),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(item.buttonText),
          )
        ],
      ),
    );
  }
}

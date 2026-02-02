// widgets/faq_tile.dart
// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/provider/faq_provider.dart';
import 'package:provider/provider.dart';


class FAQTile extends StatelessWidget {
  final int index;
  final String question;
  final String answer;

  const FAQTile({
    Key? key,
    required this.index,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isExpanded = context.watch<FAQProvider>().isExpanded(index);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.read<FAQProvider>().toggleExpanded(index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 14, color: AppColors.black),
            ),
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }
}

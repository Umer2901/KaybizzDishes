// providers/faq_provider.dart
import 'package:flutter/material.dart';

class FAQProvider with ChangeNotifier {
  final Map<int, bool> _expandedMap = {};

  bool isExpanded(int index) => _expandedMap[index] ?? false;

  void toggleExpanded(int index) {
    _expandedMap[index] = !(_expandedMap[index] ?? false);
    notifyListeners();
  }
}

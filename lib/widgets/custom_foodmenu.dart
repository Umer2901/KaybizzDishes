import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodMenuSection extends StatefulWidget {
  const FoodMenuSection({super.key});

  @override
  State<FoodMenuSection> createState() => _FoodMenuSectionState();
}

class _FoodMenuSectionState extends State<FoodMenuSection>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<String> categories = [];
  Map<String, List<Map<String, dynamic>>> menuItems = {};

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMenuData();
  }

  /// 🔥 Fetch categories + menu items dynamically
  Future<void> loadMenuData() async {
    // Fetch categories
    final catSnap = await FirebaseFirestore.instance
        .collection("menu_categories")
        .orderBy("order")
        .get();

    categories = catSnap.docs.map((d) => d["name"].toString()).toList();

    // Prepare empty lists for each category
    for (var c in categories) {
      menuItems[c] = [];
    }

    // Fetch menu items
    final itemsSnap =
        await FirebaseFirestore.instance.collection("menu_items").get();

    for (var doc in itemsSnap.docs) {
      String category = doc["category"];
      String name = doc["name"];
      String price = doc["price"];
      String imageBase64 = doc["image"]; // ALWAYS BASE64

      Uint8List bytes = base64Decode(imageBase64);

      menuItems[category]?.add({
        "name": name,
        "price": price,
        "bytes": bytes, // READY TO DISPLAY
      });
    }

    setState(() {
      isLoading = false;
      _tabController = TabController(length: categories.length, vsync: this);
    });
  }

  /// 🔥 Build each menu item row
  Widget buildMenuItem(String name, String price, Uint8List bytes) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Image.memory(bytes, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || _tabController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 900;
    final double maxWidth = isWide ? 900 : screenWidth * 0.95;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔥 Category Tabs
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController!,
                isScrollable: true,
                labelColor: Colors.deepOrange,
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.deepOrange,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                tabs: categories.map((c) => Tab(text: c)).toList(),
              ),
            ),

            // 🔥 Tab Content
            SizedBox(
              height: isWide ? 500 : 550,
              child: TabBarView(
                controller: _tabController!,
                children: categories.map((category) {
                  final items = menuItems[category] ?? [];

                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                        "No items yet",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  return GridView.count(
                    crossAxisCount: isWide ? 2 : 1,
                    childAspectRatio: isWide ? 3.0 : 2.6,
                    padding: const EdgeInsets.all(16),
                    children: items
                        .map(
                          (item) => buildMenuItem(
                            item["name"],
                            item["price"],
                            item["bytes"],
                          ),
                        )
                        .toList(),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

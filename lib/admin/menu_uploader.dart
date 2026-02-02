import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';

class FoodMenuUploader extends StatefulWidget {
  const FoodMenuUploader({super.key});

  @override
  State<FoodMenuUploader> createState() => _FoodMenuUploaderState();
}

class _FoodMenuUploaderState extends State<FoodMenuUploader> {
  Uint8List? pickedBytes;
  String? selectedCategory;

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();

  bool isUploading = false;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("menu_categories").get();

    setState(() {
      categories = snapshot.docs.map((e) => e["name"].toString()).toList();
    });
  }

  Future<void> addNewCategory() async {
    if (newCategoryController.text.trim().isEmpty) return;

    await FirebaseFirestore.instance.collection("menu_categories").add({
      "name": newCategoryController.text,
      "order": categories.length + 1,
    });

    await fetchCategories();
    selectedCategory = newCategoryController.text;
    newCategoryController.clear();
    setState(() {});
  }

  Future<void> pickWebImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        pickedBytes = result.files.single.bytes!;
      });
    }
  }

  Future<void> uploadMenuItem() async {
    if (pickedBytes == null ||
        selectedCategory == null ||
        itemNameController.text.isEmpty ||
        priceController.text.isEmpty) {
      snack("Fill all fields & pick image!");
      return;
    }

    try {
      setState(() => isUploading = true);

      String base64Image = base64Encode(pickedBytes!);

      await FirebaseFirestore.instance.collection("menu_items").add({
        "category": selectedCategory,
        "name": itemNameController.text.trim(),
        "price": priceController.text.trim(),
        "image": base64Image,
        "timestamp": FieldValue.serverTimestamp(),
      });

      pickedBytes = null;
      itemNameController.clear();
      priceController.clear();
      selectedCategory = null;

      snack("Menu item uploaded!", success: true);
      setState(() {});
    } catch (e) {
      snack("Error: $e");
    } finally {
      setState(() => isUploading = false);
    }
  }

  void snack(String msg, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    double panelWidth =
        maxWidth > 900 ? 450 : maxWidth > 600 ? maxWidth * 0.7 : maxWidth * 0.9;

    return Center(
      child: Container(
        width: panelWidth,
        margin: const EdgeInsets.symmetric(vertical: 30),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.primary,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload Food Menu Item",
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Category",
                      labelStyle: const TextStyle(fontSize: 12),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: selectedCategory,
                    items: categories
                        .map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(c, style: const TextStyle(fontSize: 12)),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => selectedCategory = v),
                  ),
                ),
                const SizedBox(width: 10),

                SizedBox(
                  width: 32,
                  height: 32,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.add_box,
                        color: Colors.white, size: 22),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Add Category",
                              style: TextStyle(fontSize: 14)),
                          content: SizedBox(
                            height: 50,
                            child: TextField(
                              controller: newCategoryController,
                              style: const TextStyle(fontSize: 13),
                              decoration: const InputDecoration(
                                  labelText: "Name", isDense: true),
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text("Cancel",
                                  style: TextStyle(fontSize: 13)),
                              onPressed: () => Navigator.pop(context),
                            ),
                            ElevatedButton(
                              child: const Text("Add",
                                  style: TextStyle(fontSize: 13)),
                              onPressed: () async {
                                await addNewCategory();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            _smallField(itemNameController, "Food Name"),
            const SizedBox(height: 14),
            _smallField(priceController, "Price"),

            const SizedBox(height: 14),

            if (pickedBytes != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  pickedBytes!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed: pickWebImage,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 13)),
                child: const Text("Pick Image"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 38,
              child: ElevatedButton(
                onPressed: isUploading ? null : uploadMenuItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(fontSize: 13),
                ),
                child: isUploading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text("Upload"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 12),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

import 'dart:typed_data';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/admin/booking_view.dart';
import 'package:flutter_application_kaybizz/admin/menu_uploader.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/widgets/custom_appbar.dart';
import 'package:flutter_application_kaybizz/widgets/custom_buttons.dart';
import 'package:sizer/sizer.dart';

class WebFirestoreImageUploader extends StatefulWidget {
  const WebFirestoreImageUploader({super.key});

  @override
  State<WebFirestoreImageUploader> createState() =>
      _WebFirestoreImageUploaderState();
}

class _WebFirestoreImageUploaderState
    extends State<WebFirestoreImageUploader> {

  Uint8List? pickedBytes;
  String? selectedType;
  bool isUploading = false;

  List<String> types = [];
  final TextEditingController newTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTypes();
  }

  Future<void> fetchTypes() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("gallery_types").get();

    setState(() {
      types = snapshot.docs.map((e) => e["name"].toString()).toList();
    });
  }

  Future<void> addNewType() async {
    final String newType = newTypeController.text.trim();
    if (newType.isEmpty) return;

    await FirebaseFirestore.instance.collection("gallery_types").add({
      "name": newType,
    });

    newTypeController.clear();
    await fetchTypes();
    setState(() => selectedType = newType);
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

  Future<void> uploadToFirestore() async {
    if (pickedBytes == null || selectedType == null) {
      showSnack("Please select image & category");
      return;
    }

    try {
      setState(() => isUploading = true);

      String base64Image = base64Encode(pickedBytes!);

      await FirebaseFirestore.instance.collection("gallery").add({
        "type": selectedType,
        "imageData": base64Image,
        "timestamp": FieldValue.serverTimestamp(),
      });

      setState(() {
        pickedBytes = null;
        selectedType = null;
      });

      showSnack("Uploaded Successfully!", success: true);
    } catch (e) {
      showSnack("Error uploading: $e");
    } finally {
      setState(() => isUploading = false);
    }
  }

  void showSnack(String msg, {bool success = false}) {
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

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // SMALL TOP BUTTON
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: 180,
                height: 36,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AllBookingsPage()),
                    );
                  },
                  child: const Text("Check Bookings"),
                ),
              ),
            ),

            // MAIN PANEL
            Center(
              child: Container(
                width: maxWidth > 900 ? 450 : maxWidth * 0.9,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Upload Gallery Image",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                            value: selectedType,
                            items: types
                                .map((t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(
                                        t,
                                        style:
                                            const TextStyle(fontSize: 12),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (v) => setState(() => selectedType = v),
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
                                  title: const Text("Add New Category",
                                      style: TextStyle(fontSize: 14)),
                                  content: SizedBox(
                                    height: 50,
                                    child: TextField(
                                      controller: newTypeController,
                                      style: const TextStyle(fontSize: 13),
                                      decoration: const InputDecoration(
                                        labelText: "Category",
                                        isDense: true,
                                      ),
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
                                        await addNewType();
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

                    const SizedBox(height: 18),

                    // IMAGE PREVIEW
                    if (pickedBytes != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          pickedBytes!,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      height: 38,
                      child: ElevatedButton(
                        onPressed: pickWebImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(fontSize: 13),
                        ),
                        child: const Text("Select Image"),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: isUploading ? null : uploadToFirestore,
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
            ),

            SizedBox(height: 8.h),

            // MENU UPLOADER PANEL (still separate widget)
            const FoodMenuUploader(),
          ],
        ),
      ),
    );
  }
}

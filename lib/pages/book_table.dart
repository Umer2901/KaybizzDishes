import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/widgets/custom_appbar.dart';
import 'package:flutter_application_kaybizz/widgets/custom_footer.dart';
import 'package:sizer/sizer.dart';

class BookTablePage extends StatefulWidget {
  const BookTablePage({super.key});

  @override
  State<BookTablePage> createState() => _BookTablePageState();
}

class _BookTablePageState extends State<BookTablePage> {
  // -------------------- Reservation --------------------
  int partySize = 2;

  // -------------------- Controllers --------------------
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController extrasController = TextEditingController();

  bool loading = false;

  // -------------------- Booking Fee --------------------
  final double bookingFee = 20.0; // £20 non-refundable

  // -------------------- Save Booking --------------------
  Future<void> confirmBooking() async {
    if (dateController.text.trim().isEmpty ||
        timeController.text.trim().isEmpty) {
      showError("Please enter date and time");
      return;
    }

    if (nameController.text.trim().isEmpty) {
      showError("Name is required");
      return;
    }

    if (mobileController.text.trim().isEmpty) {
      showError("Mobile number is required");
      return;
    }

    final email = emailController.text.trim();
    final emailValid = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(email);

    if (!emailValid) {
      showError("Enter a valid email address");
      return;
    }

    // Generate a random booking code
    String bookingCode = generateBookingCode();

    setState(() => loading = true);

    try {
      // Save booking in Firestore
      await FirebaseFirestore.instance.collection("table_bookings").add({
        "partySize": partySize,
        "date": dateController.text.trim(),
        "time": timeController.text.trim(),
        "name": nameController.text.trim(),
        "mobile": mobileController.text.trim(),
        "email": email,
        "specialAddOns": extrasController.text.trim(),
        "bookingFee": bookingFee,
        "bookingCode": bookingCode,
        "timestamp": FieldValue.serverTimestamp(),
      });

      setState(() => loading = false);

      // Show dialog
      showBookingDialog(bookingCode);
    } catch (e) {
      setState(() => loading = false);
      showError("Something went wrong");
    }
  }

  // -------------------- Generate Random Booking Code --------------------
  String generateBookingCode() {
    final random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  // -------------------- Responsive Booking Dialog --------------------
  void showBookingDialog(String bookingCode) {
    final width = MediaQuery.of(context).size.width;
    final bool isWeb = width >= 1024;
    final bool isTablet = width >= 600 && width < 1024;

    double dialogWidth = isWeb
        ? 500
        : isTablet
            ? 400
            : width * 0.9;

    showDialog(
      context: context,
      builder: (_) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: dialogWidth),
          child: Material(
            type: MaterialType.transparency,
            child: AlertDialog(
              title: const Text("Booking Confirmed 🎉",style: TextStyle(fontSize: 14),),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Your table has been booked successfully!",style: TextStyle(fontSize: 12),),
                    const SizedBox(height: 6),
                    Text(
                      "Booking Code: $bookingCode",
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Please pay £$bookingFee for the booking. "
                      "This amount is non-refundable and will be adjusted in your final bill. "
                      "If you fail to pay the fee, the booking is not confirmed.",style: TextStyle(fontSize: 12),),
                    const SizedBox(height: 6),
                    const Text(
                      "After payment, send us a screenshot along with the booking code.",style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                   // Navigator.pop(context); // Close booking page
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -------------------- UI --------------------
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1024;
    final bool isWeb = width >= 1024;

    final double containerWidth = isWeb
        ? 520
        : isTablet
            ? 600
            : width * 0.95;

    final EdgeInsets containerPadding = EdgeInsets.all(isWeb ? 16 : 20);
    final double titleSize = isWeb ? 18 : 20;
    final double fieldSpacing = isWeb ? 12 : 16;
    final double buttonHeight = isWeb ? 42 : 48;
    final double fontSizeField = isWeb ? 13 : 14;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                width: containerWidth,
                padding: containerPadding,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book a Table",
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
              
                    // Party Size
                    Text("Party Size", style: TextStyle(fontSize: fontSizeField)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<int>(
                      value: partySize,
                      items: List.generate(
                        20,
                        (i) => DropdownMenuItem(
                          value: i + 1,
                          child: Text("${i + 1}", style: TextStyle(fontSize: fontSizeField)),
                        ),
                      ),
                      onChanged: (v) => setState(() => partySize = v!),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
              
                    // Date & Time
                    _compactField(controller: dateController, label: "Date (DD/MM/YYYY) *", fontSize: fontSizeField),
                    _compactField(controller: timeController, label: "Time (e.g. 7:30 PM) *", fontSize: fontSizeField),
                    SizedBox(height: fieldSpacing),
              
                    // Personal Info
                    _compactField(controller: nameController, label: "Your Name *", fontSize: fontSizeField),
                    _compactField(controller: mobileController, label: "Mobile Number *", keyboard: TextInputType.phone, fontSize: fontSizeField),
                    _compactField(controller: emailController, label: "Email Address *", keyboard: TextInputType.emailAddress, fontSize: fontSizeField),
                    SizedBox(height: fieldSpacing),
              
                    // Special Add-ons
                    const Text("Special Add-ons (Optional)"),
                    const SizedBox(height: 6),
                    TextField(
                      controller: extrasController,
                      maxLines: 3,
                      style: TextStyle(fontSize: fontSizeField),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Write here...",
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: fieldSpacing + 8),
              
                    // Booking fee info
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Booking Fee: £$bookingFee (non-refundable, adjusted in final bill).",
                        style: TextStyle(fontSize: fontSizeField),
                      ),
                    ),
                    SizedBox(height: fieldSpacing + 8),
              
                    // Confirm Button
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: loading ? null : confirmBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: isWeb ? 10 : 14),
                        ),
                        child: loading
                            ? SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                ),
                              )
                            : Text(
                                "Confirm Booking",
                                style: TextStyle(fontSize: fontSizeField),
                              ),
                      ),
                    ),
                 
                  ],
                ),
              ),
              SizedBox(height: 5.h,),
                    Container(
              color: AppColors.white,
              child: FooterWidget(),
            ),
            Container(
              height: 4.h,
              width: double.infinity,
              color: AppColors.primary,
              child: const Center(
                child: Text(
                  "KaybizzDishes © 2024. All Rights Reserved.",
                  style: TextStyle(fontSize: 10, color: AppColors.white),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------- Compact Field --------------------
  Widget _compactField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboard = TextInputType.text,
    double fontSize = 14,
  }) {
    final width = MediaQuery.of(context).size.width;
    final bool isWeb = width >= 1024;

    return Padding(
      padding: EdgeInsets.only(bottom: isWeb ? 10 : 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: fontSize),
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}

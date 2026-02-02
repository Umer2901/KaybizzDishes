import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/constants/images.dart';
import 'package:flutter_application_kaybizz/widgets/custom_appbar.dart';
import 'package:flutter_application_kaybizz/widgets/custom_footer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  /// Unified send method (WASM safe)
  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'umerimtiaz457@gmail.com',
      queryParameters: {
        'subject': _subjectController.text,
        'body':
            'Name: ${_nameController.text}\nEmail: ${_emailController.text}\n\n${_messageController.text}',
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri, mode: LaunchMode.platformDefault);
        _showSnackBar("Email client opened successfully!");
      } else {
        _showSnackBar("Could not launch email client.", isError: true);
      }
    } catch (e) {
      _showSnackBar("Error sending email: $e", isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    bool isMobile = true,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: TextStyle(fontSize: isMobile ? 14 : 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: isMobile ? 14 : 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: isMobile ? 12 : 14,
          horizontal: 12,
        ),
      ),
    );
  }

  Widget _contactForm(bool isMobile) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _nameController,
            label: "Name",
            isMobile: isMobile,
            validator: (value) =>
                value == null || value.isEmpty ? 'Name is required' : null,
          ),
          SizedBox(height: 2.h),
          _buildTextField(
            controller: _emailController,
            label: "Email",
            isMobile: isMobile,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email is required';
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 2.h),
          _buildTextField(
            controller: _subjectController,
            label: "Subject",
            isMobile: isMobile,
            validator: (value) =>
                value == null || value.isEmpty ? 'Subject is required' : null,
          ),
          SizedBox(height: 2.h),
          _buildTextField(
            controller: _messageController,
            label: "Message",
            maxLines: isMobile ? 5 : 6,
            isMobile: isMobile,
            validator: (value) =>
                value == null || value.isEmpty ? 'Message is required' : null,
          ),
          SizedBox(height: 3.h),
          Center(
            child: SizedBox(
              width: isMobile ? double.infinity : 150,
              child: ElevatedButton(
                onPressed: _sendEmail,
                child: const Text("Send"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _contactViaWhatsApp() async {
    final String phone = '+447880856064';
    final String message =
        'Hello, I want to contact EasyPrint. Name: ${_nameController.text}, Email: ${_emailController.text}';

    final Uri whatsappUrl = Uri.parse(
        "https://wa.me/$phone?text=${Uri.encodeComponent(message)}");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      _showSnackBar("Could not open WhatsApp.", isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 229, 230),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 5.w : 10.w,
                vertical: 2.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  Divider(thickness: 0.5, color: AppColors.primary),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Divider(thickness: 0.5, color: AppColors.primary),
                  SizedBox(height: 3.h),

                  /// Responsive layout
                  isMobile
                      ? Column(
                          children: [
                            Container(
                              height: 30.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/food.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            _contactForm(true),
                          ],
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 18.sp),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/food.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Flexible(
                                flex: 1,
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 400),
                                  child: _contactForm(false),
                                ),
                              ),
                            ],
                          ),
                        ),

                  SizedBox(height: 5.h),
                ],
              ),
            ),

            /// Footer
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
    );
  }
}

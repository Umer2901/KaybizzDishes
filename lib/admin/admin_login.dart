import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/admin/upload_iamge.dart';
import 'package:flutter_application_kaybizz/widgets/custom_appbar.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  final String adminEmail = "kaybizz@dishes";
  final String adminPassword = "kaybizz@dishes";

  void login() {
    setState(() => loading = true);

    final email = emailController.text.trim();
    final pass = passwordController.text.trim();

    if (email == adminEmail && pass == adminPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WebFirestoreImageUploader()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Credentials!"),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
       appBar: CustomAppBar(),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: maxWidth > 600 ? 320 : maxWidth * 0.8, // MUCH SMALLER
          padding: const EdgeInsets.all(16), // SMALLER PADDING
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Admin Login",
                style: TextStyle(
                  fontSize: 16,                // SMALLER TEXT
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              TextField(
                controller: emailController,
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(fontSize: 12),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(fontSize: 12),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10), // SMALLER BUTTON
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                  child: loading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

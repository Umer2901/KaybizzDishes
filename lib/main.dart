


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:flutter_application_kaybizz/provider/faq_provider.dart';
import 'package:flutter_application_kaybizz/provider/tab_controller_provider.dart';
import 'package:flutter_application_kaybizz/router.dart';
import 'package:flutter_application_kaybizz/widgets/custom_mega.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
    options: FirebaseOptions(
  apiKey: "AIzaSyBIo-6M6QEMjFeVq5uv37EDldp1EjNVvc4",
  //authDomain: "kaybizz-87bd0.firebaseapp.com",
  projectId: "kaybizz-87bd0",
  // storageBucket: "kaybizz-87bd0.firebasestorage.app",
  messagingSenderId: "92518850964",
   appId: "1:92518850964:web:e0a7d3fb46998ee1aaef81",
  // measurementId: "G-99970EDCQC"
      )

  );
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ GoRouter setup
  
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
           providers: [
             ChangeNotifierProvider(create: (context) => FAQProvider()),
             ChangeNotifierProvider(create: (context) => TabProvider()),
             ChangeNotifierProvider(create: (context) => MegaMenuProvider()),
        ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'KayBizzDishes',
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              textTheme: TextTheme(
                displaySmall: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                headlineLarge: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                headlineMedium: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                headlineSmall: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                bodyLarge: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                bodyMedium: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                bodySmall: TextStyle(
                  fontSize: 6.sp,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                ),
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              useMaterial3: true,
            ),
            routerConfig: router,
          ),
        );
      },
    );
  }
}

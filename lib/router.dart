import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/admin/admin_login.dart';
import 'package:flutter_application_kaybizz/home.dart';
import 'package:flutter_application_kaybizz/pages/book_table.dart';
import 'package:flutter_application_kaybizz/pages/contact.dart';
import 'package:flutter_application_kaybizz/pages/gallery.dart';
import 'package:flutter_application_kaybizz/pages/menu.dart';
import 'package:flutter_application_kaybizz/pages/splash.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
  path: '/splash',
  name: 'splash',
  builder: (context, state) => SplashScreen(
    nextPage: Home(), // 👈 REQUIRED
  ),
),

    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => Home(),
    ),

     GoRoute(
      path: '/bookatable',
      name: 'bookatable',
      builder: (context, state) => BookTablePage(),
    ),

    GoRoute(
      path: '/menu',
      name: 'menu',
      builder: (context, state) => Menu(),
    ),

    GoRoute(
      path: '/gallery',
      name: 'gallery',
      builder: (context, state) => FirebaseGallery(),
    ),

    GoRoute(
      path: '/contactus',
      name: 'contactus',
      builder: (context, state) => ContactPage(),
    ),

    GoRoute(
      path: '/admin',
      name: 'admin',
      builder: (context, state) => AdminLoginPage(),
    ),
   

  ],
);

// // import 'dart:async';
// // import 'dart:math' as math;
// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart'; // ✅ ADD THIS
// // import 'package:sizer/sizer.dart';

// // class SplashScreen extends StatefulWidget {
// //   final Widget nextPage; // (optional now, but keeping because your code has it)
// //   final String logoAssetPath;
// //   final Duration totalDuration;

// //   const SplashScreen({
// //     super.key,
// //     required this.nextPage,
// //     this.logoAssetPath = "assets/images/logo.png",
// //     this.totalDuration = const Duration(milliseconds: 2300),
// //   });

// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }

// // class _SplashScreenState extends State<SplashScreen>
// //     with SingleTickerProviderStateMixin {
// //   late final AnimationController _c;
// //   late final Animation<double> _open;

// //   @override
// //   void initState() {
// //     super.initState();

// //     _c = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 1400),
// //     );

// //     _open = CurvedAnimation(
// //       parent: _c,
// //       curve: Curves.easeInOutCubic,
// //     );

// //     WidgetsBinding.instance.addPostFrameCallback((_) async {
// //       if (!mounted) return;

// //       await Future.delayed(const Duration(milliseconds: 250));
// //       if (!mounted) return;

// //       _c.forward();

// //       await Future.delayed(widget.totalDuration);
// //       if (!mounted) return;

// //       // ✅ GoRouter navigation (updates URL)
// //       context.go('/home');
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _c.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final w = MediaQuery.of(context).size.width;

// //     final isMobile = w < 600;
// //     final isTablet = w >= 600 && w < 1024;

// //     final double logoSize = isMobile
// //         ? 22.w
// //         : isTablet
// //             ? 16.w
// //             : math.min(160.0, 12.w);

// //     final double panelWidth = math.max(220, w * 0.5);
// //     final double panelHeight = math.max(420, MediaQuery.of(context).size.height);

// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: Stack(
// //         alignment: Alignment.center,
// //         children: [
// //           Positioned(
// //             child: Container(
// //               width: logoSize * 2.8,
// //               height: logoSize * 2.8,
// //               decoration: BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 gradient: RadialGradient(
// //                   colors: [
// //                     Colors.deepOrange.withOpacity(0.22),
// //                     Colors.transparent,
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),

// //           Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Image.asset(
// //                 widget.logoAssetPath,
// //                 width: logoSize,
// //                 height: logoSize,
// //                 fit: BoxFit.contain,
// //                 filterQuality: FilterQuality.high,
// //               ),
// //               SizedBox(height: 2.h),
// //               Text(
// //                 "KaybizzDishes",
// //                 style: TextStyle(
// //                   color: Colors.white.withOpacity(0.95),
// //                   fontSize: isMobile ? 14.sp : 12.sp,
// //                   fontWeight: FontWeight.w700,
// //                   letterSpacing: 0.6,
// //                 ),
// //               ),
// //               SizedBox(height: 0.8.h),
// //               AnimatedBuilder(
// //                 animation: _open,
// //                 builder: (_, __) {
// //                   return Opacity(
// //                     opacity: (1 - _open.value).clamp(0.0, 1.0),
// //                     child: Text(
// //                       "Opening...",
// //                       style: TextStyle(
// //                         color: Colors.white.withOpacity(0.65),
// //                         fontSize: isMobile ? 10.sp : 9.sp,
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ],
// //           ),

// //           AnimatedBuilder(
// //             animation: _open,
// //             builder: (_, __) {
// //               final dx = (panelWidth / 2) * _open.value;

// //               return IgnorePointer(
// //                 child: Stack(
// //                   alignment: Alignment.center,
// //                   children: [
// //                     Transform.translate(
// //                       offset: Offset(-dx, 0),
// //                       child: Align(
// //                         alignment: Alignment.center,
// //                         child: _doorPanel(
// //                           width: panelWidth / 2,
// //                           height: panelHeight,
// //                           isLeft: true,
// //                         ),
// //                       ),
// //                     ),
// //                     Transform.translate(
// //                       offset: Offset(dx, 0),
// //                       child: Align(
// //                         alignment: Alignment.center,
// //                         child: _doorPanel(
// //                           width: panelWidth / 2,
// //                           height: panelHeight,
// //                           isLeft: false,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _doorPanel({
// //     required double width,
// //     required double height,
// //     required bool isLeft,
// //   }) {
// //     return Container(
// //       width: width,
// //       height: height,
// //       decoration: BoxDecoration(
// //         gradient: LinearGradient(
// //           begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
// //           end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
// //           colors: const [
// //             Color(0xFF0B0B0B),
// //             Color(0xFF111111),
// //             Color(0xFF0B0B0B),
// //           ],
// //         ),
// //       ),
// //       child: Stack(
// //         children: [
// //           Align(
// //             alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
// //             child: Container(
// //               width: 2,
// //               height: double.infinity,
// //               color: Colors.deepOrange.withOpacity(0.25),
// //             ),
// //           ),
// //           Opacity(
// //             opacity: 0.08,
// //             child: CustomPaint(
// //               size: Size(width, height),
// //               painter: _DoorNoisePainter(),
// //             ),
// //           ),
// //           Positioned(
// //             top: height * 0.48,
// //             left: isLeft ? width - 32 : 16,
// //             child: Container(
// //               width: 14,
// //               height: 44,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10),
// //                 color: Colors.white.withOpacity(0.12),
// //                 border: Border.all(color: Colors.white.withOpacity(0.10)),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _DoorNoisePainter extends CustomPainter {
// //   final _rand = math.Random(4);

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final p = Paint()..color = Colors.white;
// //     for (int i = 0; i < 180; i++) {
// //       final x = _rand.nextDouble() * size.width;
// //       final y = _rand.nextDouble() * size.height;
// //       final r = _rand.nextDouble() * 1.6;
// //       canvas.drawCircle(Offset(x, y), r, p);
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// // }
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sizer/sizer.dart';

// class SplashScreen extends StatefulWidget {
//   final Widget nextPage;
//   final String logoAssetPath;

//   /// Set this close to your video length (yours looked ~7–8s)
//   final Duration totalDuration;

//   const SplashScreen({
//     super.key,
//     required this.nextPage,
//     this.logoAssetPath = "assets/images/logo.png",
//     this.totalDuration = const Duration(milliseconds: 7700),
//   });

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _c;

//   // Phase animations
//   late final Animation<double> _bgToBlack;     // white -> black
//   late final Animation<double> _centerLine;    // thin center line appears
//   late final Animation<double> _logoFadeIn;    // logo fade in
//   late final Animation<double> _logoDrop;      // logo moves down a bit
//   late final Animation<double> _doorsOpen;     // doors open

//   @override
//   void initState() {
//     super.initState();

//     _c = AnimationController(vsync: this, duration: widget.totalDuration);

//     // 0.00 - 0.18 : white -> black
//     _bgToBlack = CurvedAnimation(
//       parent: _c,
//       curve: const Interval(0.00, 0.18, curve: Curves.easeInOut),
//     );

//     // 0.05 - 0.16 : center thin line (like the video)
//     _centerLine = CurvedAnimation(
//       parent: _c,
//       curve: const Interval(0.05, 0.16, curve: Curves.easeInOutCubic),
//     );

//     // 0.30 - 0.52 : logo fade in
//     _logoFadeIn = CurvedAnimation(
//       parent: _c,
//       curve: const Interval(0.30, 0.52, curve: Curves.easeOutCubic),
//     );

//     // 0.52 - 0.70 : logo drops down slightly
//     _logoDrop = CurvedAnimation(
//       parent: _c,
//       curve: const Interval(0.52, 0.70, curve: Curves.easeInOutCubic),
//     );

//     // 0.78 - 1.00 : doors open to reveal page
//     _doorsOpen = CurvedAnimation(
//       parent: _c,
//       curve: const Interval(0.78, 1.00, curve: Curves.easeInOutCubic),
//     );

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       if (!mounted) return;
//       _c.forward();

//       // Navigate right at the end (keeps URL correct)
//       _c.addStatusListener((status) {
//         if (status == AnimationStatus.completed && mounted) {
//           context.go('/home');
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _c.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final w = size.width;

//     final isMobile = w < 600;
//     final isTablet = w >= 600 && w < 1024;

//     final double logoSize = isMobile
//         ? 22.w
//         : isTablet
//             ? 16.w
//             : math.min(160.0, 12.w);

//     final double panelWidth = math.max(220, w * 0.55);
//     final double panelHeight = math.max(420, size.height);

//     return Scaffold(
//       body: AnimatedBuilder(
//         animation: _c,
//         builder: (_, __) {
//           // Background blends from white -> black early (video style)
//           final bg = Color.lerp(Colors.white, Colors.black, _bgToBlack.value)!;

//           // Logo drop distance (slight)
//           final dropY = lerpDouble(0.0, size.height * 0.10, _logoDrop.value);

//           // Doors open distance
//           final dx = (panelWidth / 2) * _doorsOpen.value;

//           return Stack(
//             fit: StackFit.expand,
//             children: [
//               // ✅ Real reveal: next page behind everything
//               widget.nextPage,

//               // ✅ Splash overlay
//               Container(color: bg),

//               // ✅ Center thin vertical line phase (white -> black moment)
//               Align(
//                 alignment: Alignment.center,
//                 child: Opacity(
//                   opacity: (1.0 - _bgToBlack.value).clamp(0.0, 1.0),
//                   child: Container(
//                     width: lerpDouble(2.0, 10.0, _centerLine.value),
//                     height: size.height * 0.95,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),

//               // ✅ Glow behind logo (subtle)
//               Center(
//                 child: Opacity(
//                   opacity: (_logoFadeIn.value * 0.9).clamp(0.0, 1.0),
//                   child: Container(
//                     width: logoSize * 2.6,
//                     height: logoSize * 2.6,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: RadialGradient(
//                         colors: [
//                           Colors.deepOrange.withOpacity(0.18),
//                           Colors.transparent,
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // ✅ Logo + brand text (fade in, then drop down)
//               Transform.translate(
//                 offset: Offset(0, dropY ?? 0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Opacity(
//                       opacity: _logoFadeIn.value.clamp(0.0, 1.0),
//                       child: Image.asset(
//                         widget.logoAssetPath,
//                         width: logoSize,
//                         height: logoSize,
//                         fit: BoxFit.contain,
//                         filterQuality: FilterQuality.high,
//                       ),
//                     ),
//                     SizedBox(height: 1.6.h),
//                     Opacity(
//                       opacity: _logoFadeIn.value.clamp(0.0, 1.0),
//                       child: Text(
//                         "KaybizzDishes",
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.92),
//                           fontSize: isMobile ? 14.sp : 12.sp,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 0.6,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // ✅ Doors (cover screen, then open at the end)
//               IgnorePointer(
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Transform.translate(
//                       offset: Offset(-dx, 0),
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: _doorPanel(
//                           width: panelWidth / 2,
//                           height: panelHeight,
//                           isLeft: true,
//                         ),
//                       ),
//                     ),
//                     Transform.translate(
//                       offset: Offset(dx, 0),
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: _doorPanel(
//                           width: panelWidth / 2,
//                           height: panelHeight,
//                           isLeft: false,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _doorPanel({
//     required double width,
//     required double height,
//     required bool isLeft,
//   }) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
//           end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
//           colors: const [
//             Color(0xFF0B0B0B),
//             Color(0xFF111111),
//             Color(0xFF0B0B0B),
//           ],
//         ),
//       ),
//       child: Stack(
//         children: [
//           Align(
//             alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
//             child: Container(
//               width: 2,
//               height: double.infinity,
//               color: Colors.deepOrange.withOpacity(0.25),
//             ),
//           ),
//           Opacity(
//             opacity: 0.08,
//             child: CustomPaint(
//               size: Size(width, height),
//               painter: _DoorNoisePainter(),
//             ),
//           ),
//           Positioned(
//             top: height * 0.48,
//             left: isLeft ? width - 32 : 16,
//             child: Container(
//               width: 14,
//               height: 44,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white.withOpacity(0.12),
//                 border: Border.all(color: Colors.white.withOpacity(0.10)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DoorNoisePainter extends CustomPainter {
//   final _rand = math.Random(4);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final p = Paint()..color = Colors.white;
//     for (int i = 0; i < 180; i++) {
//       final x = _rand.nextDouble() * size.width;
//       final y = _rand.nextDouble() * size.height;
//       final r = _rand.nextDouble() * 1.6;
//       canvas.drawCircle(Offset(x, y), r, p);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// // small helper (no extra imports)
// double? lerpDouble(double a, double b, double t) => a + (b - a) * t;
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextPage;
  final String logoAssetPath;
  final Duration totalDuration;

  const SplashScreen({
    super.key,
    required this.nextPage,
    this.logoAssetPath = "assets/images/logo.png",
    this.totalDuration = const Duration(milliseconds: 2600),
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  // Doors open first
  late final Animation<double> _openDoors;

  // Then logo shows pixelated -> sharp + fade
  late final Animation<double> _logoFade;
  late final Animation<double> _logoSharpen; // drives pixel-resolve
  late final Animation<double> _logoScalePop;

  @override
  void initState() {
    super.initState();

    _c = AnimationController(vsync: this, duration: widget.totalDuration);

    // 0.00 - 0.55 : doors opening from center
    _openDoors = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.00, 0.55, curve: Curves.easeInOutCubic),
    );

    // 0.55 - 0.85 : logo fades in
    _logoFade = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.55, 0.85, curve: Curves.easeOutCubic),
    );

    // 0.55 - 1.00 : pixelated -> sharp (via scaling + no filter)
    _logoSharpen = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.55, 1.00, curve: Curves.easeOutCubic),
    );

    // Optional tiny "focus pop"
    _logoScalePop = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.55, 0.92, curve: Curves.easeOutBack),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      _c.forward();

      await Future.delayed(widget.totalDuration);
      if (!mounted) return;

      // ✅ GoRouter navigation (updates URL)
      context.go('/home');
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;

    final isMobile = w < 600;
    final isTablet = w >= 600 && w < 1024;

    final double logoSize = isMobile
        ? 22.w
        : isTablet
            ? 16.w
            : math.min(160.0, 12.w);

    // Doors cover full screen
    final double panelWidth = w;
    final double panelHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ show next page behind (gives real reveal feel)
          widget.nextPage,

          // ✅ dark overlay base (splash world)
          Container(color: Colors.black),

          // ✅ Logo appears AFTER doors start opening (pixelated -> sharp)
          AnimatedBuilder(
            animation: _c,
            builder: (_, __) {
              final opacity = _logoFade.value.clamp(0.0, 1.0);

              // Pixel resolve: start very small (blocky) -> normal (sharp)
              // Lower start value = bigger pixel blocks
              final pixelScale = lerpDouble(0.08, 1.0, _logoSharpen.value);

              // Optional gentle focus pop (slight overshoot)
              final pop = lerpDouble(0.92, 1.0, _logoScalePop.value);

              return Center(
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: pixelScale * pop,
                    child: Image.asset(
                      widget.logoAssetPath,
                      width: logoSize,
                      height: logoSize,
                      fit: BoxFit.contain,

                      // 🔥 KEY: disables smoothing so scaling looks pixelated
                      filterQuality: FilterQuality.none,
                    ),
                  ),
                ),
              );
            },
          ),

          // ✅ Doors opening from center
          AnimatedBuilder(
            animation: _openDoors,
            builder: (_, __) {
              final dx = (panelWidth / 2) * _openDoors.value;

              return IgnorePointer(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(-dx, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: _doorPanel(
                          width: panelWidth / 2,
                          height: panelHeight,
                          isLeft: true,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(dx, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: _doorPanel(
                          width: panelWidth / 2,
                          height: panelHeight,
                          isLeft: false,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _doorPanel({
    required double width,
    required double height,
    required bool isLeft,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
          colors: const [
            Color(0xFF0B0B0B),
            Color(0xFF111111),
            Color(0xFF0B0B0B),
          ],
        ),
      ),
      child: Stack(
        children: [
          // center seam glow
          Align(
            alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 2,
              height: double.infinity,
              color: Colors.deepOrange.withOpacity(0.22),
            ),
          ),

          // optional subtle noise texture
          Opacity(
            opacity: 0.06,
            child: CustomPaint(
              size: Size(width, height),
              painter: _DoorNoisePainter(),
            ),
          ),

          // optional handle hint (comment out if you don't want it)
          Positioned(
            top: height * 0.48,
            left: isLeft ? width - 32 : 16,
            child: Container(
              width: 14,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.10),
                border: Border.all(color: Colors.white.withOpacity(0.10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoorNoisePainter extends CustomPainter {
  final _rand = math.Random(4);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white;
    for (int i = 0; i < 180; i++) {
      final x = _rand.nextDouble() * size.width;
      final y = _rand.nextDouble() * size.height;
      final r = _rand.nextDouble() * 1.6;
      canvas.drawCircle(Offset(x, y), r, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

double lerpDouble(double a, double b, double t) => a + (b - a) * t;

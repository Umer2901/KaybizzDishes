import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';

/// Drop-in, highly configurable hero/banner with optional background image
class HeroBannerPro extends StatelessWidget {
  const HeroBannerPro({
    super.key,
    // MEDIA
    this.image, // ← now optional
    this.fitMobile = BoxFit.fill,
    this.fitLarger = BoxFit.cover,
    this.overlayColor = const Color(0x99000000),
    this.gradientOverlay,
    // SIZING
    this.mobileAspectRatio = 16 / 9,
    this.mobileHeight,
    this.tabletHeight = 520,
    this.desktopHeight = 680,
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 1024,
    // CONTENT
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.maxContentWidth = 1100,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.contentAlignment = Alignment.center,
    // BUTTON
    this.buttonLabel,
    this.onButtonPressed,
    this.buttonBackground = const Color.fromARGB(255, 255, 191, 0),
    this.buttonForeground = Colors.black87,
    this.buttonPaddingMobile = const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    this.buttonPaddingLarger = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.buttonShape = const StadiumBorder(),
    // SPACING
    this.titleBottomSpacing = 24,
    this.subtitleBottomSpacing = 28,
  });

  /// Now optional
  final ImageProvider? image;

  final BoxFit fitMobile;
  final BoxFit fitLarger;

  final double? mobileHeight;
  final double mobileAspectRatio;
  final double tabletHeight;
  final double desktopHeight;

  final double mobileBreakpoint;
  final double tabletBreakpoint;

  final Gradient? gradientOverlay;
  final Color overlayColor;

  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double maxContentWidth;
  final EdgeInsets contentPadding;
  final Alignment contentAlignment;

  final String? buttonLabel;
  final VoidCallback? onButtonPressed;
  final Color buttonBackground;
  final Color buttonForeground;
  final EdgeInsets buttonPaddingMobile;
  final EdgeInsets buttonPaddingLarger;
  final OutlinedBorder buttonShape;

  final double titleBottomSpacing;
  final double subtitleBottomSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final isMobile = w < mobileBreakpoint;
      final isTablet = w >= mobileBreakpoint && w < tabletBreakpoint;

      final double height = isMobile
          ? (mobileHeight ?? (w / mobileAspectRatio))
          : (isTablet ? tabletHeight : desktopHeight);

      final double baseTitle = isMobile ? 28 : (isTablet ? 56 : 96);
      final double baseSubtitle = isMobile ? 14 : (isTablet ? 16 : 18);

      final textTheme = Theme.of(context).textTheme;

      final TextStyle resolvedTitleStyle = (titleStyle ??
          textTheme.displaySmall?.copyWith(
            fontSize: baseTitle,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.08,
          ))!;

      final TextStyle resolvedSubtitleStyle = (subtitleStyle ??
          textTheme.bodyLarge?.copyWith(
            fontSize: baseSubtitle,
            color: Colors.white,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ))!;

      final EdgeInsets buttonPad =
          isMobile ? buttonPaddingMobile : buttonPaddingLarger;

      return SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image (optional)
            if (image != null)
              Image(
                image: image!,
                fit: isMobile ? fitMobile : fitLarger,
              )
            else
              Container(
                color: Colors.black, // fallback background
              ),

            // Overlays
            if (gradientOverlay != null)
              Container(decoration: BoxDecoration(gradient: gradientOverlay)),
            Container(color: overlayColor),

            // Content
            Align(
              alignment: contentAlignment,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: Padding(
                  padding: contentPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: resolvedTitleStyle,
                      ),
                      SizedBox(height: titleBottomSpacing),

                      if (subtitle != null) ...[
                        Text(
                          subtitle!,
                          textAlign: TextAlign.center,
                          style: resolvedSubtitleStyle,
                        ),
                        SizedBox(height: subtitleBottomSpacing),
                      ],

                      if (buttonLabel != null && onButtonPressed != null)
                        ElevatedButton(
                          onPressed: onButtonPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            padding: buttonPad,
                            shape: buttonShape,
                            elevation: 2,
                          ),
                          child: Text(
                            buttonLabel!,
                            style: const TextStyle(color: AppColors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

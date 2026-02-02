import 'package:flutter/material.dart';

/// One card with background image + dark overlay + centered title/subtitle.
/// Now with responsive typography to avoid overflow.
class OverlayImageCard extends StatelessWidget {
  const OverlayImageCard({
    super.key,
    required this.image,
    required this.title,
    this.subtitle,
    this.onTap,
    this.aspectRatio = 4 / 3,       // similar to your screenshot
    this.overlayColor = const Color(0x88000000),
    this.borderRadius = 12,

    // Responsive typography knobs
    this.titleBase = 22,            // base size scaled from card width
    this.titleMin = 16,
    this.titleMax = 28,
    this.subtitleBase = 14,
    this.subtitleMin = 12,
    this.subtitleMax = 18,
    this.titleMaxLines = 3,
    this.subtitleMaxLines = 3,
  });

  final ImageProvider image;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final double aspectRatio;
  final Color overlayColor;
  final double borderRadius;

  // Typography controls
  final double titleBase;
  final double titleMin;
  final double titleMax;
  final double subtitleBase;
  final double subtitleMin;
  final double subtitleMax;
  final int titleMaxLines;
  final int subtitleMaxLines;

  double _scaled(double width, double base, double min, double max) {
    // Scale relative to a reference width (360). Tweak as needed.
    final scaled = (width / 360.0) * base;
    return scaled.clamp(min, max);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(image: image, fit: BoxFit.cover),
            Container(color: overlayColor), // dark sheet

            // Use LayoutBuilder to compute font sizes based on actual card width
            LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = constraints.maxWidth;

                final titleSize =
                    _scaled(cardWidth, titleBase, titleMin, titleMax);
                final subtitleSize =
                    _scaled(cardWidth, subtitleBase, subtitleMin, subtitleMax);

                final titleStyle = (theme.textTheme.headlineSmall ??
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
                    .copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  fontSize: titleSize,
                );

                final subtitleStyle = (theme.textTheme.bodyLarge ??
                        const TextStyle(fontSize: 14))
                    .copyWith(
                  color: Colors.white,
                  height: 1.45,
                  fontWeight: FontWeight.w400,
                  fontSize: subtitleSize,
                );

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: titleStyle,
                          maxLines: titleMaxLines,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                        if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Text(
                            subtitle!,
                            textAlign: TextAlign.center,
                            style: subtitleStyle,
                            maxLines: subtitleMaxLines,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      ),
    );
  }
}

/// Responsive grid that lays out the cards in a row (3/2/1 columns).
class FeaturesRow extends StatelessWidget {
  const FeaturesRow({
    super.key,
    required this.items,
    this.gap = 24,
    this.desktopBreakpoint = 1024,
    this.tabletBreakpoint = 600,
    this.aspectRatio = 4 / 3,
  });

  final List<OverlayImageCard> items;
  final double gap;
  final double desktopBreakpoint;
  final double tabletBreakpoint;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final w = c.maxWidth;
      int crossAxisCount;
      if (w >= desktopBreakpoint) {
        crossAxisCount = 3;
      } else if (w >= tabletBreakpoint) {
        crossAxisCount = 2;
      } else {
        crossAxisCount = 1;
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: gap,
          mainAxisSpacing: gap,
          childAspectRatio: aspectRatio,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) => items[i],
      );
    });
  }
}

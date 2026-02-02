import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/admin/admin_login.dart';
import 'package:flutter_application_kaybizz/admin/upload_iamge.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart'; // Assuming you have defined custom colors
import 'package:flutter_application_kaybizz/home.dart';
import 'package:flutter_application_kaybizz/pages/book_table.dart';
import 'package:flutter_application_kaybizz/pages/gallery.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../pages/about.dart';
import '../pages/contact.dart';

class MegaMenuProvider with ChangeNotifier {
  int? _hoveredTab;
  OverlayEntry? _overlayEntry;

  int? get hoveredTab => _hoveredTab;

  void setHoveredTab(BuildContext context, int? index, Rect? tabRect, List<String> items, double fontSize) {
    _hoveredTab = index;
    notifyListeners();

    _overlayEntry?.remove();
    _overlayEntry = null;

    if (index != null && tabRect != null && items.isNotEmpty) {
      Overlay.of(context)!.insert(_overlayEntry!);
    }
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _hoveredTab = null;
    notifyListeners();
  }
}

class CalendarMegaTabs extends StatefulWidget {
  const CalendarMegaTabs({super.key});

  @override
  State<CalendarMegaTabs> createState() => _CalendarMegaTabsState();
}

class _CalendarMegaTabsState extends State<CalendarMegaTabs> {
  // Top-level tabs
  final List<String> tabTitles = const [
    'Home',
    'Book a Table',
    'Menu',
    'Gallery',
    'Contact Us',
    'Login',
  ];

  int? _hoveredIndex; // for hover underline

  double _getResponsiveFontSize(double width) {
    if (width >= 1200) return 15;
    if (width >= 800) return 14;
    if (width >= 600) return 13;
    return 12;
  }

  // Drawer-style bottom sheet for mobile/tablet: shows ALL tabs
  void _openDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (_) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: tabTitles.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (ctx, i) {
            final title = tabTitles[i];
            return ListTile(
              title: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.orange), // Orange color
              ),
              onTap: () {
                Navigator.pop(ctx);
                _onTabTap(title);
              },
            );
          },
        );
      },
    );
  }

  void _onTabTap(String title) {
    switch (title) {
      case 'Home':
      context.go('/home');
        break;

      case 'Book a Table':
      context.go('/bookatable');
        break;
     case 'Menu':
      context.go('/menu');
        break;
      case 'Gallery':
        context.go('/gallery');
        break;
      case 'Contact Us':
       context.go('/contactus');
        break;
         case 'Login':
        context.go('/admin');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isCompact = width < 900; // phone & many tablets
    final fontSize = _getResponsiveFontSize(width);

    // Compact: menu button + label, opens drawer listing ALL tabs
    if (isCompact) {
      return Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _openDrawer(context),
            tooltip: '',
          ),
        
        ],
      );
    }

    // Desktop/Web: horizontal row with hover underline feedback
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: Colors.transparent,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(tabTitles.length, (index) {
            final title = tabTitles[index];
            final hovered = _hoveredIndex == index;

            return MouseRegion(
              onEnter: (_) => setState(() => _hoveredIndex = index),
              onExit: (_) => setState(() => _hoveredIndex = null),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () => _onTabTap(title),
                  borderRadius: BorderRadius.circular(6),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          // thin line only when hovered
                          color: hovered ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.orange, // Orange color
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}


// ignore_for_file: use_super_parameters, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_kaybizz/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCategory {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String priceSubText;

  ProductCategory({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.priceSubText,
  });
}

class ProductCategoryGrid extends StatelessWidget {
  final List<ProductCategory> categories;

  const ProductCategoryGrid({
    Key? key,
    required this.categories,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    if (screenWidth < 600) {
      crossAxisCount = 1;
    } else if (screenWidth < 1024) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 4;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.h,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(category: category);
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final ProductCategory category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                category.imageUrl,
                height: 35.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            /// Title
            Text(
              category.title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            /// Description
            Expanded(
              child: Text(
                category.description,
                style: const TextStyle(fontSize: 11.5, color: Colors.black87),
                overflow: TextOverflow.fade,
                maxLines: 5,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 10),

            /// Price + Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (category.price.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'from',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        category.price,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                      ),
                      if (category.priceSubText.isNotEmpty)
                        Text(
                          category.priceSubText,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                    ],
                  ),
                const Spacer(),
                ElevatedButton(
                   onPressed: () async{
    final Uri whatsappUri = Uri.parse("https://wa.me/447402171149");

      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not open WhatsApp."),
            backgroundColor: Colors.red,
          ),
        );
      }
  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Order Now',
                    style: TextStyle(fontSize: 12, color: AppColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

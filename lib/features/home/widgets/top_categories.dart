import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/product_category/view/category_deals_screen.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, ProductCategoryScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        // itemExtent: 75,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(
              context,
              GlobalVariables.categoryImages[index]['title']!,
            ),
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  right: defaultPadding / 2, left: defaultPadding / 2),
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2, vertical: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultPadding),
                  color: GlobalVariables.greyBackgroundCOlor),
              child: Text(
                GlobalVariables.categoryImages[index]['title']!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/common_widget/stars.dart';
import 'package:i_shop_riverpod/features/product_details/view/product_details_screen.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({
    super.key,
    required this.widget,
    required this.avgRating,
  });

  final ProductDetailScreen widget;
  final double avgRating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.product.id!,
          ),
          Stars(
            rating: avgRating,
          ),
        ],
      ),
    );
  }
}

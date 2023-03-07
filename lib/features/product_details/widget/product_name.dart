import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/features/product_details/view/product_details_screen.dart';

class ProductName extends StatelessWidget {
  const ProductName({
    super.key,
    required this.widget,
  });

  final ProductDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Text(
        widget.product.name!,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}


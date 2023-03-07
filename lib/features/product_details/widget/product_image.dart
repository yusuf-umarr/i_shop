import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/features/product_details/view/product_details_screen.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.widget,
  });

  final ProductDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.product.images!.map<Widget>(
        (i) {
          return Builder(
            builder: (BuildContext context) => ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                i,
                fit: BoxFit.contain,
                height: 200,
              ),
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 300,
      ),
    );
  }
}

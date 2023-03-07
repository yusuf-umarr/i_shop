import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_button.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/notifiers/cart_notifier.dart';
import 'package:i_shop_riverpod/features/cart/view/cart_screen.dart';
import 'package:i_shop_riverpod/features/product_details/widget/product_detail_app_bar.dart';
import 'package:i_shop_riverpod/features/product_details/widget/product_image.dart';
import 'package:i_shop_riverpod/features/product_details/widget/product_name.dart';
import 'package:i_shop_riverpod/features/product_details/widget/product_price_desc.dart';
import 'package:i_shop_riverpod/features/product_details/widget/product_rating.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = '/product-details';
  var product;
  ProductDetailScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
  }

  void navigateToCartScreen() {
    Navigator.pushNamed(
      context,
      CartScreen.routeName,
    );
  }

  void addToCart() {
    ref.read(cartNotifier.notifier).addToCart(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: productDetailAppBarTitle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductRating(widget: widget, avgRating: avgRating),
            ProductName(widget: widget),
            ProductImage(widget: widget),
            productPriceDescription(widget.product),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Buy Now',
                onTap: () {
                  addToCart();
                  navigateToCartScreen();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Add to Cart',
                onTap: addToCart,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 5,
            ),
          ],
        ),
      ),
    );
  }


}



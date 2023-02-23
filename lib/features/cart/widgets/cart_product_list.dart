import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/cart_view_model.dart';
import 'package:i_shop_riverpod/features/cart/widgets/cart_product.dart';

class CartProductList extends StatelessWidget {
  const CartProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final productCart = ref.watch(cartViewModel);
      productCart.cartProducts.sort(((a, b) => a.product!.name!
          .toLowerCase()
          .compareTo(b.product!.name!.toLowerCase())));

      return Expanded(
        child: ListView.builder(
          itemCount: productCart.cartProducts.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var product = productCart.cartProducts[index];

            return CartProduct(
              product: product,
            );
          },
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/notifiers/cart_notifier.dart';
import 'package:i_shop_riverpod/features/cart/widgets/cart_product.dart';

class CartProductList extends StatefulWidget {
  const CartProductList({
    super.key,
  });

  @override
  State<CartProductList> createState() => _CartProductListState();
}

class _CartProductListState extends State<CartProductList>
     {
  
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final productCart = ref.watch(cartNotifier);
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

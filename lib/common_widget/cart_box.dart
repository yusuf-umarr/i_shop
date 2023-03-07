import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/notifiers/cart_notifier.dart';
import 'package:i_shop_riverpod/features/cart/view/cart_screen.dart';

class CartBox extends StatelessWidget {
  const CartBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CartScreen.routeName);
      },
      child: Container(
        height: 42,
        width: 32,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.shopping_cart_outlined,
                  color: Colors.black, size: 25),
            ),
            Consumer(builder: (context, ref, _) {
              final cartItem = ref.watch(cartNotifier).cartProducts.length;
              return Positioned(
                top: 0,
                right: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    alignment: Alignment.center,
                    height: 18,
                    width: 18,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Text(
                      "$cartItem",
                      style: const TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

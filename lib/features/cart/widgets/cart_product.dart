import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/notifiers/cart_notifier.dart';
import 'package:i_shop_riverpod/features/cart/model/product_cart_model.dart';
import 'package:i_shop_riverpod/features/product_category/models/product_model.dart';

class CartProduct extends ConsumerWidget {
  ProductCartModel product;
  CartProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productModel = product;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  productModel.product!.images![0],
                  fit: BoxFit.fill,
                  height: 125,
                  width: 140,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${productModel.product!.name}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    productModel.product!.price.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  const Text('Eligible for FREE Shipping'),
                  const Text(
                    'In Stock',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 25, bottom: 25),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(5),
                color: Colors.black12,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      ref
                          .read(cartNotifier.notifier)
                          .removeFromCart(productModel.product as ProductModel);
                    },
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        size: 18,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Text(
                        product.quantity.toString(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ref
                          .read(cartNotifier.notifier)
                          .addToCart(productModel.product as ProductModel);
                    },
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

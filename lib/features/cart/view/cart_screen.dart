import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/cart/widgets/cart_app_bar.dart';
import 'package:i_shop_riverpod/features/cart/widgets/cart_product_list.dart';
import 'package:i_shop_riverpod/features/cart/widgets/cart_subtotal.dart';
import 'package:i_shop_riverpod/features/cart/widgets/proceed_to_by_btn.dart';
import 'package:i_shop_riverpod/features/home/widgets/address_box.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    // Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
 

    // print(userCart!.cart!.length);
    // int sum = 0;
    // user.cart
    //     .map((e) => sum += e['quantity'] * e['product']['price'] as int)
    //     .toList();

    // int sum = 0;
    // userCart!.cart!.map((e) => sum += e.quantity! * e.product!.price).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: cartAppBar(),
        ),
      ),
      body: Column(
        children: [
          const AddressBox(),
          const CartSubtotal(),
          const ProceedToBuyButton(),
          const SizedBox(height: 15),
          Divider(color: Colors.black12.withOpacity(0.08)),
          const SizedBox(height: 5),
          const CartProductList(),
        ],
      ),
    );
  }
}




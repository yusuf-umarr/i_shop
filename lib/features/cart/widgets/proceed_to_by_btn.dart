import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_button.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/cart_view_model.dart';

class ProceedToBuyButton extends StatelessWidget {
  const ProceedToBuyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer(builder: (context, ref, _) {
        final productCart = ref.watch(cartViewModel);
        return CustomButton(
          text: 'Proceed to Buy (${productCart.cartProducts.length} items)',
          onTap: () => navigateToAddress(),
        );
      }),
    );
  }

  void navigateToAddress() {
    // Navigator.pushNamed(
    //   context,
    //   AddressScreen.routeName,
    //   arguments: sum.toString(),
    // );
  }
}

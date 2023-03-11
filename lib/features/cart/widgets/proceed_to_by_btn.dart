import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_button.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/user_notifier.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/notifiers/cart_notifier.dart';
import 'package:i_shop_riverpod/features/payment/view/address_screen.dart';
import 'package:i_shop_riverpod/features/auth/view/auth_screen.dart';

class ProceedToBuyButton extends ConsumerWidget {
  ProceedToBuyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifier);
    var sum = 0.0;
    cartState.cartProducts
        .map((e) => sum += e.quantity! * e.product!.price!.toDouble())
        .toList();

    final userState = ref.watch(userNotifier);
    void navigateToAddress() {
      if (userState.loadState == NetworkState.success) {
        Navigator.pushNamed(
          context,
          AddressScreen.routeName,
          arguments: sum,
        );
      } else {
        Navigator.pushNamed(
          context,
          AuthScreen.routeName,
          arguments: "cart-screen"
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer(builder: (context, ref, _) {
        final productCart = ref.watch(cartNotifier);
        return CustomButton(
          text: productCart.cartProducts.isNotEmpty
              ? 'Proceed to Buy (${productCart.cartProducts.length} items)'
              : "Empty Cart",
          onTap: () {
            if (productCart.cartProducts.isNotEmpty) {
              navigateToAddress();
            }
          },
          color: GlobalVariables.primaryColor,
        );
      }),
    );
  }
}

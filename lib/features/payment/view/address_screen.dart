import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_button.dart';
import 'package:i_shop_riverpod/common_widget/custom_textfield.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/constants/utils.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/notifiers/cart_notifier.dart';
import 'package:i_shop_riverpod/features/payment/payment_view_model/payment_view_model.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/user_notifier.dart';
import 'package:i_shop_riverpod/features/bottomNav/view/bottom_nav_bar.dart';
import 'package:i_shop_riverpod/features/payment/payment_view_model/payment_view_model_state.dart';
import 'package:i_shop_riverpod/features/payment/view/checkout_screen.dart';

import '../../cart/cart_view_model/notifiers/post_cart_notifier.dart';

class AddressScreen extends ConsumerStatefulWidget {
  static const String routeName = '/address';
  String totalAmount;
  AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  ConsumerState<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  final cardFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void payPressed() {
    final userAddr = ref.watch(userNotifier).user.address;
    final userEmail = ref.watch(userNotifier).user.email;
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';

        ref.read(userNotifier.notifier).updateUserAddress(addressToBeUsed);

        ref
            .read(paymentViewModel.notifier)
            .checkOut(userEmail!, widget.totalAmount);
      } else {
        return showSnackBar(context, 'Please enter all the values!');
      }
    } else if (userAddr != null) {
      addressToBeUsed = userAddr;
      ref.read(userNotifier.notifier).updateUserAddress(addressToBeUsed);
      ref
          .read(paymentViewModel.notifier)
          .checkOut(userEmail!, widget.totalAmount);
    } else {
      showSnackBar(context, 'Fill the require details');
    }
  }

  void navigateToHome() {
    Navigator.pushNamed(
      context,
      BottomBar.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(userNotifier);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text("Address"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: Consumer(builder: (context, ref, _) {
        final cartItem = ref.watch(cartNotifier).cartProducts;
        ref.listen<PaymentViewState>(paymentViewModel, (prev, state) {
          if (state.loadState == NetworkState.error) {
            showSnackBar(context, state.message.toString());
          } else if (state.loadState == NetworkState.success) {
            showSnackBar(context, "You are been redirected to paystack");

            // print("sucesssssssssss");

            ref.read(postCartNotifier.notifier).postOrder(cartItem);
            Navigator.pushReplacementNamed(
              context,
              CheckoutScreen.routeName,
            );
          }
        });

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (authState.user.address != "")
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            authState.user.address.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: flatBuildingController,
                        hintText: 'Flat, House no, Building',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: areaController,
                        hintText: 'Area, Street',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: pincodeController,
                        hintText: 'Pincode',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: cityController,
                        hintText: 'Town/City',
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: "Proceed to pay",
                  onTap: () {
                    payPressed();
                    // ref.read(postCartNotifier.notifier).postOrder();
                  },
                  color: GlobalVariables.primaryColor,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

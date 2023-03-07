import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/cart/widgets/cart_app_bar.dart';
import 'package:i_shop_riverpod/features/cart/widgets/cart_product_list.dart';
import 'package:i_shop_riverpod/features/cart/widgets/cart_subtotal.dart';
import 'package:i_shop_riverpod/features/cart/widgets/proceed_to_by_btn.dart';
import 'package:i_shop_riverpod/features/home/widgets/address_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  void navigateToSearchScreen(String query) {
    // Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  String? userToken;

  void checkUserAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('x-auth-token');
  }

  late AnimationController _cartItemController;
  late Animation<double> _animationCart;

  @override
  void initState() {
    super.initState();
    checkUserAuth();

    _setupCartListAnimation();
  }

  @override
  void dispose() {
    _cartItemController.dispose();
    super.dispose();
  }

  void _setupCartListAnimation() {
    _cartItemController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _animationCart = CurvedAnimation(
        parent: _cartItemController, curve: const Interval(0.0, 1));
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
          title: cartAppBar(),
        ),
      ),
      body: Column(
        children: [
          AddressBox(),
          const CartSubtotal(),
          ProceedToBuyButton(),
          const SizedBox(height: 15),
          Divider(color: Colors.black12.withOpacity(0.08)),
          const SizedBox(height: 5),
          const CartProductList(),
        ],
      ),
    );
  }
}

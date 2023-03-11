import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/features/bottomNav/view/bottom_nav_bar.dart';
import 'package:i_shop_riverpod/features/payment/view/address_screen.dart';
import 'package:i_shop_riverpod/features/auth/view/auth_screen.dart';
import 'package:i_shop_riverpod/features/cart/view/cart_screen.dart';
import 'package:i_shop_riverpod/features/payment/view/checkout_screen.dart';
import 'package:i_shop_riverpod/features/profile/view/setting_sceen.dart';
import '../../../features/product_category/view/category_deals_screen.dart';
import '../../../features/product_details/view/product_details_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      var prevPage = routeSettings.arguments as String;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AuthScreen(
          prevPage: prevPage,
        ),
      );

   
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
  

    case ProductCategoryScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductCategoryScreen(
          category: category,
        ),
      );
  
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as dynamic;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );
    case CheckoutScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CheckoutScreen(),
      );
    case SettingScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SettingScreen(),
      );

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount.toString(),
        ),
      );
   
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}

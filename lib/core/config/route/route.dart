import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/features/auth/view/auth_screen.dart';
import 'package:i_shop_riverpod/features/cart/view/cart_screen.dart';
// import 'package:i_shop_riverpod/features/product_category/view/category_deals_screen.dart';

import '../../../features/product_category/view/category_deals_screen.dart';
import '../../../features/product_details/view/product_details_screen.dart';
// import 'package:i_shop_riverpod/src/features/account/model/order_model.dart';
// import 'package:i_shop_riverpod/src/features/address/view/address_screen.dart';
// import 'package:i_shop_riverpod/src/features/authentication/view/auth_screen.dart';
// import 'package:i_shop_riverpod/src/features/bottomNav/view/bottom_nav_bar.dart';
// import 'package:i_shop_riverpod/src/features/cart/view/cart_screen.dart';
// import 'package:i_shop_riverpod/src/features/home/view/category_deals_screen.dart';
// import 'package:i_shop_riverpod/src/features/home/view/home_screen.dart';
// import 'package:i_shop_riverpod/src/features/product_details/view/product_details_screen.dart';
// import 'package:i_shop_riverpod/src/features/search/view/search_screen.dart';
// import 'package:i_shop_riverpod/src/features/seller/view/add_product_screen.dart';

// import 'src/features/other_detail/view/other_detail_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    // case HomeScreen.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const HomeScreen(),
    //   );
    // case BottomBar.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const BottomBar(),
    //   );
    // case AddProductScreen.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const AddProductScreen(),
    //   );

    case ProductCategoryScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductCategoryScreen(
          category: category,
        ),
      );
    // case SearchScreen.routeName:
    //   var searchQuery = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => SearchScreen(
    //       searchQuery: searchQuery,
    //     ),
    //   );
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
        builder: (_) => const CartScreen(
        ),
      );
    // case AddressScreen.routeName:
    //   var totalAmount = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => AddressScreen(
    //       totalAmount: totalAmount,
    //     ),
    //   );
    // case OrderDetailScreen.routeName:
    //   var order = routeSettings.arguments as OrderModel;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => OrderDetailScreen(
    //       order: order,
    //     ),
    //   );
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

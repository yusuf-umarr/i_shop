import 'package:flutter/material.dart';


String baseUrl = 'https://i-shop-server.netlify.app/.netlify/functions/api/';
String dealOdDayPath = 'product/deal-of-day/';
String productCategoryPath = 'product/products/';
String allProductCategoryPath = 'product/all-products/';
String loginPath = 'auth/signin';
String registerPath = 'auth/signup';
String addressPath = 'auth/save-user-address';
String updateUserPath = 'auth/update-user';
String validateTokenPath = 'auth/tokenIsValid';
String getUserPath = 'auth/get-user';
String getOrderPath = 'user/user-orders';
String postOrderPath = 'user/order-product';
String initializedUrl = 'https://api.paystack.co/transaction/initialize';
String payStackApi = 'sk_test_73669334a5577c3de3519affd0b44c11015233b0';
String paymentUrl = 'https://paystack.shop/i-shop';
String defaultPic = "assets/images/profilePics.jpeg";
String profilePic = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
String netError = "assets/images/internet-error.png";

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 54, 40, 19);
  static const backgroundColor = Colors.white;
  static var greyBackgroundColor = Color.fromRGBO(163, 181, 192, 0.2);
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const Color greyCOlor = Color.fromRGBO(241, 214, 223, 0.3);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const primaryColor = Color.fromARGB(255, 29, 201, 192);

  // STATIC IMAGES
  static const List<String> carouselImages = [
    "assets/images/store4.jpg",
    "assets/images/store1.jpeg",
    "assets/images/store2.jpeg",
    "assets/images/store3.jpeg",
    "assets/images/store5.jpg",
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'All',
      // 'image': 'assets/images/fashion.jpeg',
    },
    {
      'title': 'Fashion',
      // 'image': 'assets/images/fashion.jpeg',
    },
    {
      'title': 'Mobiles',
      // 'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      // 'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      // 'image': 'assets/images/appliances.jpeg',
    },
  ];
}

const defaultDuration = Duration(milliseconds: 600);
const double defaultPadding = 20.0;

MyGlobals myGlobals = MyGlobals();

class MyGlobals {
  GlobalKey? _scaffoldKey;
  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey? get scaffoldKey => _scaffoldKey;
}

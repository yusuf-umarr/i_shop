// import 'dart:convert';
// import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class ProductDetailsServices {
//   void addToCart({
//     required BuildContext context,
//     required var product,
//   }) async {
//     final userProvider = Provider.of<AuthViewModel>(context, listen: false);
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('x-auth-token');
//     if (token == null) {
//       prefs.setString('x-auth-token', '');
//     }

//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/add-to-cart'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token!,
//         },
//         body: jsonEncode({
//           'id': product!,
//         }),
//       );

//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           User user =
//               userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
//           userProvider.setUserFromModel(user);
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   void rateProduct({
//     required BuildContext context,
//     required var product,
//     required double rating,
//   }) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('x-auth-token');
//     if (token == null) {
//       prefs.setString('x-auth-token', '');
//     }

//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/rate-product'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token!,
//         },
//         body: jsonEncode({
//           'id': product.id!,
//           'rating': rating,
//         }),
//       );

//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {},
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
// }

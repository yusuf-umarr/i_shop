import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/common_widget/toggle_btn.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool provider = true;

    return Container(
      decoration: BoxDecoration(color: Colors.green),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(provider == "user" ? "Buyer" : "Seller"),
          const ToggleBotton(),
        ],
      ),
    );
  }
}

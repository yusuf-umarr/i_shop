import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/common_widget/cart_box.dart';

void navigateToSearchScreen(String query) {
  // Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
}

Row productDetailAppBarTitle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Container(
          height: 42,
          margin: const EdgeInsets.only(left: 15),
          child: Material(
            borderRadius: BorderRadius.circular(7),
            elevation: 1,
            child: TextFormField(
              onFieldSubmitted: navigateToSearchScreen,
              decoration: InputDecoration(
                prefixIcon: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 6,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 23,
                    ),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.only(top: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black38,
                    width: 1,
                  ),
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ),
      CartBox()
    ],
  );
}

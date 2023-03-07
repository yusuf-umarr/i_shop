  import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';

Column productPriceDescription(product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.black12,
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: RichText(
            text: TextSpan(
              text: 'Deal Price: ',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '\$${product.price}',
                  style: const TextStyle(
                    fontSize: 22,
                    color: GlobalVariables.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(product.description!),
        ),
        Container(
          color: Colors.black12,
          height: 5,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

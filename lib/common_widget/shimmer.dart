import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:shimmer/shimmer.dart';

Widget sliderShimmer({double height = 20, double width = 10}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[200]!,
    child: Container(
      height: height,
      width: width,
      color: Colors.grey[200],
    ),
  );
}

Widget dealOfDayShimmer(Size size) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: sliderShimmer(height: 25, width: size.width * 0.3)),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: sliderShimmer(height: 235, width: size.width * 0.7),
        ),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              child: sliderShimmer(height: 30, width: size.width * 0.1)),
        ),
      ),
    ],
  );
}

Widget productCategoryShimmer({required size, height = defaultPadding * 3}) {
  return GridView.builder(
    // padding: const EdgeInsets.only(left: 15),
    itemCount: 8,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: size.width * 0.06,
      // mainAxisSpacing: size.height * 0.03,
      mainAxisExtent: size.height * 0.38,
    ),
    itemBuilder: (context, index) {
      return Column(
        children: [
          SizedBox(
            height: height,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: sliderShimmer(
                height: size.height * 0.28, width: size.width * 0.4),
          ),
        ],
      );
    },
  );
}

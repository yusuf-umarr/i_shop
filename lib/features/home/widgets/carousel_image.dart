
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/shimmer.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/home/view_model/home_view_model.dart';

class CarouselImage extends ConsumerWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealState = ref.watch(dealOfDayViewModel);
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map(
        (i) {
          return Builder(
            builder: (BuildContext context) =>
                dealState.loadState == NetworkState.loading
                    ? sliderShimmer(height: 200, width: double.infinity)
                    : Image.network(
                        i,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1, // to take all available width
        height: 200,
      ),
    );
  }
}

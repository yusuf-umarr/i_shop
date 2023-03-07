import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/shimmer.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/home/view_model/home_view_model.dart';

import '../../product_details/view/product_details_screen.dart';

// import '../services/home_repository.dart';

class DealOfDay extends ConsumerStatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  ConsumerState<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends ConsumerState<DealOfDay> {
  var product;
  // final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    ref.read(dealOfDayViewModel.notifier).fetchDealOfDay();
  }

  navigateToDetailScreen(productDeal) {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final Size size = MediaQuery.of(context).size;
      final dealState = ref.watch(dealOfDayViewModel);
      if (dealState.loadState == NetworkState.loading) {
        return Center(
          child: dealOfDayShimmer(size),
        );
      } else if (dealState.loadState == NetworkState.error) {
        return const Center(
          child: Text("An error occurred"),
        );
      }
      return Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 15, bottom: 25),
            child: const Text(
              'Deal of the day',
              style: TextStyle(fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductDetailScreen.routeName,
                arguments: dealState.dealOfDayProduct,
              );
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: dealState.dealOfDayProduct.images![0],
                    fit: BoxFit.fill,
                    height: 235,
                    width: size.width * 0.7,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '\$ ${dealState.dealOfDayProduct.price}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                  child: Text(
                    '${dealState.dealOfDayProduct.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: dealState.dealOfDayProduct.images!
                        .map<Widget>(
                          (e) => ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: e,
                              fit: BoxFit.fill,
                              height: 130,
                              width: 150,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ).copyWith(left: 15),
            alignment: Alignment.topLeft,
            child: Text(
              'See all deals',
              style: TextStyle(
                color: Colors.cyan[800],
              ),
            ),
          ),
        ],
      );
    });
  }
}

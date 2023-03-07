import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/home/widgets/home_app_bar.dart';
import '../widgets/address_box.dart';
import '../widgets/carousel_image.dart';
import '../widgets/deal_of_day.dart';
import '../widgets/top_categories.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const HomeAppBar(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            const CarouselImage(),
            const SizedBox(height: 10),
            const TopCategories(),
            const SizedBox(height: 10),
            const DealOfDay(),
          ],
        ),
      ),
    );
  }
}

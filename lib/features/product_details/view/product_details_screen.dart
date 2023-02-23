import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_button.dart';
import 'package:i_shop_riverpod/common_widget/stars.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/cart_view_model.dart';
import 'package:i_shop_riverpod/features/cart/view/cart_screen.dart';
import 'package:i_shop_riverpod/features/product_details/widget/product_detail_app_bar.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = '/product-details';
  var product;
  ProductDetailScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  // final ProductDetailsServices productDetailsServices =
  //     ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  // var provider;

  @override
  void initState() {
    super.initState();

    // provider =
    //     Provider.of<HomeViewModel>(context, listen: false).selectedProduct;
    // print(provider.id);

    // double totalRating = 0;
    // for (int i = 0; i < provider.ratings!.length; i++) {
    //   totalRating += provider.ratings![i]["rating"];
    //   // if (provider.ratings![i]["userId"] ==
    //   //     Provider.of<AuthViewModel>(context, listen: false).user.id) {
    //   //   myRating = provider.ratings![i]["rating"].toDouble();
    //   // }
    // }

    // if (totalRating != 0) {
    //   avgRating = totalRating / provider.ratings!.length;
    // }
  }

  void navigateToCartScreen() {
    Navigator.pushNamed(
      context,
      CartScreen.routeName,
    );
  }

  void addToCart() {
    ref.read(cartViewModel.notifier).addToCart(widget.product);
  }

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
          title: productDetailAppBarTitle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  Stars(
                    rating: avgRating,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                widget.product.name!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images!.map<Widget>(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        i,
                        fit: BoxFit.contain,
                        height: 200,
                      ),
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
              ),
            ),
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
                      text: '\$${widget.product.price}',
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
              child: Text(widget.product.description!),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Buy Now',
                onTap: () {
                  addToCart();
                  navigateToCartScreen();
                },
                color: GlobalVariables.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Add to Cart',
                onTap: addToCart,
                color: GlobalVariables.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                // productDetailsServices.rateProduct(
                //   context: context,
                //   product: provider,
                //   rating: rating,
                // );
              },
            )
          ],
        ),
      ),
    );
  }
}

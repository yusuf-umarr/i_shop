import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/cart_box.dart';
import 'package:i_shop_riverpod/common_widget/shimmer.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/product_category/view_model/category_view_model.dart';
import 'package:i_shop_riverpod/features/product_details/view/product_details_screen.dart';

class ProductCategoryScreen extends ConsumerStatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const ProductCategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  ConsumerState<ProductCategoryScreen> createState() =>
      _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends ConsumerState<ProductCategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _categoryController;
  late Animation<double> _animationCategory;
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
    _setupCategoryAnimation();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  void _setupCategoryAnimation() {
    _categoryController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _animationCategory = CurvedAnimation(
        parent: _categoryController, curve: const Interval(0.0, 1));
  }

  fetchCategoryProducts() async {
    if (widget.category == "All") {
      ref.read(categoryViewModel.notifier).fetchAllProductCategory();
    } else {
      ref
          .read(categoryViewModel.notifier)
          .fetchProductCategory(widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding / 2),
              child: CartBox(),
            )
          ],
        ),
      ),
      body: Consumer(builder: (context, ref, _) {
        final categoryState = ref.watch(categoryViewModel);
        if (categoryState.loadState == NetworkState.loading) {
          return productCategoryShimmer(size: size);
        } else if (categoryState.loadState == NetworkState.error) {
          return Center(
            child: Text(categoryState.message.toString()),
          );
        }
        return AnimatedBuilder(
            animation: Listenable.merge([_categoryController]),
            builder: (context, _) {
              if (categoryState.loadState == NetworkState.success) {
                _categoryController.forward();
              }
              return Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    alignment: Alignment.center,
                    child: Text(
                      'Shopping for ${widget.category} Category',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      itemCount: categoryState.productCategory.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: size.width * 0.06,
                        mainAxisSpacing: size.height * 0.03,
                        mainAxisExtent: size.height * 0.32,
                      ),
                      itemBuilder: (context, index) {
                        final product = categoryState.productCategory[index];
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(defaultPadding),
                              color: GlobalVariables.greyBackgroundCOlor),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 50 * (1 - _animationCategory.value),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ProductDetailScreen.routeName,
                                      arguments: product,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: defaultPadding,
                                      ),
                                      CachedNetworkImage(
                                        imageUrl: product.images![0],
                                        fit: BoxFit.contain,
                                        height: 130,
                                        width: 150,
                                      ),
                                      Container(
                                        width: size.width * 0.4,
                                        height: size.height * 0.1,
                                        child: Stack(
                                          children: [
                                            Container(),
                                            Positioned(
                                              bottom: 1,
                                              left: 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product.name!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: defaultPadding / 3,
                                                  ),
                                                  Text(
                                                    "\$${product.price}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: FloatingActionButton.small(
                                                heroTag: "$index",
                                                backgroundColor: Colors.white,
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    ProductDetailScreen
                                                        .routeName,
                                                    arguments: product,
                                                  );
                                                },
                                                child:
                                                    Icon(Icons.arrow_forward),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            });
      }),
    );
  }
}

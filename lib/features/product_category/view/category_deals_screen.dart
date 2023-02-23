import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class _ProductCategoryScreenState extends ConsumerState<ProductCategoryScreen> {
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    ref.read(categoryViewModel.notifier).fetchProductCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Consumer(builder: (context, ref, _) {
        final categoryState = ref.watch(categoryViewModel);
        if (categoryState.loadState == NetworkState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (categoryState.loadState == NetworkState.error) {
          return const Center(
            child: Text("An error occurred"),
          );
        }
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.topLeft,
              child: Text(
                'Keep shopping for ${widget.category}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              // height: 170,
              child: GridView.builder(
                padding: const EdgeInsets.only(left: 15),
                itemCount: categoryState.productCategory.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //no of item to display in row
                ),
                itemBuilder: (context, index) {
                  final product = categoryState.productCategory[index];
                  return GestureDetector(
                    onTap: () {
                      // homeViewModel.setSelectedProduct(product);
                      Navigator.pushNamed(
                        context,
                        ProductDetailScreen.routeName,
                        arguments: product,
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: GlobalVariables.primaryColor
                                    .withOpacity(0.5),
                                width: 0.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  product.images![0],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                            left: 0,
                            top: 5,
                            right: 15,
                          ),
                          child: Text(
                            product.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
      }),
    );
  }
}

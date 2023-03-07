import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/shimmer.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/account/model/order_model.dart';
import 'package:i_shop_riverpod/features/profile/models/my_order_model.dart';
import 'package:i_shop_riverpod/features/profile/notifiers/order_notifier.dart';
import 'package:intl/intl.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders>
    with SingleTickerProviderStateMixin {
  late AnimationController _orderController;
  late Animation<double> _animationOrder;
  List<OrderModel>? orderProducts;

  void _setupOrderAnimation() {
    _orderController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _animationOrder = CurvedAnimation(
        parent: _orderController, curve: const Interval(0.0, 1));
  }

  @override
  void initState() {
    super.initState();
    fetchOrderProduct();
    _setupOrderAnimation();
  }

  @override
  void dispose() {
    _orderController.dispose();
    super.dispose();
  }

  void fetchOrderProduct() {
    ref.read(orderNotifier.notifier).fetchOrderProduct();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      final orderState = ref.watch(orderNotifier);
      if (orderState.loadState == NetworkState.loading) {
        return Expanded(
          child: productCategoryShimmer(size: size, height: 0.0),
        );
      } else if (orderState.loadState == NetworkState.loading) {
        return Center(
          child: Text(orderState.message.toString()),
        );
      }

      return AnimatedBuilder(
          animation: Listenable.merge([_orderController]),
          builder: (context, _) {
            if (orderState.loadState == NetworkState.success) {
              _orderController.forward();
            }
            return Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                itemCount: orderState.orderList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: defaultPadding,
                  crossAxisSpacing: defaultPadding,
                  mainAxisExtent: size.height * 0.32,
                ),
                itemBuilder: (context, index) {
                  MyOrderModel product = orderState.orderList[index];

                  print(product.orderedAt);

                  var date =
                      DateTime.fromMillisecondsSinceEpoch(product.orderedAt);

                  var formatedDate =
                      DateFormat('dd/MM/yyyy, HH:mm').format(date);

                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   OrderDetailScreen.routeName,
                      //   arguments: orderProducts![index],
                      // );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultPadding),
                          color: GlobalVariables.greyBackgroundColor),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 50 * (1 - _animationOrder.value),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: defaultPadding,
                                      left: defaultPadding),
                                  child: Row(
                                    children: [
                                      Text("Order Id: "),
                                      SizedBox(
                                        width: size.width * 0.2,
                                        child: Text(
                                          product.id
                                              .substring(product.id.length - 7),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Image.network(
                                  product.cartProducts[0].images[0],
                                  height: size.height * 0.13,
                                ),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Price: ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "\$${product.cartProducts[0].price.toString()}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: defaultPadding / 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Date: ",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        "${formatedDate.toString()}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          });
    });
  }
}

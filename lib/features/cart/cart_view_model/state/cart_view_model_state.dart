// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/cart/model/product_cart_model.dart';

class CartViewModelState {
  final CartState cartState;
  final String? message;
  final List<ProductCartModel> cartProducts;
  CartViewModelState({
    required this.cartState,
    required this.message,
    required this.cartProducts,
  });

  factory CartViewModelState.initial() {
    return CartViewModelState(
      cartState: CartState.empty,
      message: null,
    cartProducts: [],
    );
  }



 

  CartViewModelState copyWith({
    CartState? cartState,
    String? message,
    List<ProductCartModel>? cartProducts,
  }) {
    return CartViewModelState(
      cartState: cartState ?? this.cartState,
      message: message ?? this.message,
      cartProducts: cartProducts ?? this.cartProducts,
    );
  }
}

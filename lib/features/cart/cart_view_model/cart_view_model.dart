import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/features/account/model/product_model.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/cart_view_model_state.dart';
import 'package:i_shop_riverpod/features/cart/model/product_cart_model.dart';

class CartViewModel extends StateNotifier<CartViewModelState> {
  CartViewModel() : super(CartViewModelState.initial());

  void addToCart(ProductModel product) {
    var exist = state.cartProducts
        .where((element) => element.product!.id == product.id)
        .isNotEmpty;

    if (exist) {
      int newQty = 0;
      final List<ProductCartModel> oldCart = state.cartProducts.where((ele) {
        if (ele.id == product.id) {
          newQty = ele.quantity!;
        }
        return ele.id != product.id;
      }).toList();

      state = state.copyWith(cartProducts: [
        ...oldCart,
        ProductCartModel(
          id: product.id,
          product: product,
          quantity: newQty + 1,
        ),
      ]);
    } else {
      state = state.copyWith(cartProducts: [
        ...state.cartProducts,
        ProductCartModel(product: product, id: product.id, quantity: 1)
      ]);
    }
  }

  void removeFromCart(ProductModel product) {
    var exist = state.cartProducts
        .where((element) => element.product!.id == product.id)
        .isNotEmpty;

    if (exist) {
      int newQty = 0;
      final List<ProductCartModel> oldCart = state.cartProducts.where((ele) {
        if (ele.id == product.id) {
          newQty = ele.quantity!;
        }
        return ele.id != product.id;
      }).toList();

      if (newQty > 1) {
        state = state.copyWith(cartProducts: [
          ...oldCart,
          ProductCartModel(
            id: product.id,
            product: product,
            quantity: newQty - 1,
          ),
        ]);
      } else {
        state = state.copyWith(cartProducts: [
          ...state.cartProducts,
        ]);
      }
    }
  }
}

final cartViewModel = StateNotifierProvider<CartViewModel, CartViewModelState>(
    (ref) => CartViewModel());

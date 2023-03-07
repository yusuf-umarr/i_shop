import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/features/cart/cart_view_model/state/post_cart_state.dart';
import 'package:i_shop_riverpod/features/cart/service/cart_repository.dart';

class PostCartNotifier extends StateNotifier<PostCartState> {
  final CartRepository _cartRepository;
  PostCartNotifier(this._cartRepository) : super(PostCartState.initial());


  void postOrder(cartProducts) async {
    try {
      var response = await _cartRepository.postOrderProduct(cartProducts);

      if (response.success) {
        print(response.data);
        state = state.copyWith(
            // dealOfDayProduct: response.data,
            // loadState: NetworkState.success,
            );
        return;
      }
      state = state.copyWith(
        // loadState: NetworkState.error,
        message: response.message,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

final postCartNotifier = StateNotifierProvider<PostCartNotifier, PostCartState>(
    (ref) => PostCartNotifier(ref.read(cartRepository)));

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/profile/service/profile_repository.dart';
import 'package:i_shop_riverpod/features/profile/states/order_state.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier(this._profileRepository)
      : super(OrderState.initial());

  final ProfileRepository _profileRepository;

  void fetchOrderProduct() async {
    try {
      final response =
          await _profileRepository.fetchOrderedProduct();

      if (response.success) {
        state = state.copyWith(
          orderList:response.data as List<dynamic>,
          loadState: NetworkState.success,
        );
        return;
      }
      print("error here");
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
    } catch (e) {
         print("error here second");
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }
}

final orderNotifier =
    StateNotifierProvider.autoDispose<OrderNotifier, OrderState>(
  (ref) => OrderNotifier(
    ref.read(profileRepository),
  ),
);

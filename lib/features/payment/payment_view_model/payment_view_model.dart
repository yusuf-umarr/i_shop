import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/payment/payment_view_model/payment_view_model_state.dart';
import 'package:i_shop_riverpod/features/payment/services/payment_reposioty.dart';

class PaymentViewModel extends StateNotifier<PaymentViewState> {
  PaymentViewModel(this._paymentRepository) : super(PaymentViewState.initial());

  final PaymentRepository _paymentRepository;

  void checkOut(String email, String amount) async {
    try {
      final response = await _paymentRepository.checkOut(email, amount);

      // print("check out response==============");
      // print(response.data);

      if (response.success) {
        state = state.copyWith(
          paymentModel: response.data,
          loadState: NetworkState.success,
          message: response.message,
        );
        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }
}

final paymentViewModel =
    StateNotifierProvider<PaymentViewModel, PaymentViewState>(
  (ref) => PaymentViewModel(
    ref.read(paymentRepository),
  ),
);

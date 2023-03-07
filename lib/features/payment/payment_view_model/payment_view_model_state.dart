// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/payment/model/payment_model.dart';

class PaymentViewState {
  final NetworkState loadState;
  final PaymentModel paymentModel;
  final String? message;
  // final PaymentState paymentState;

  PaymentViewState({
    required this.loadState,
    required this.paymentModel,
    required this.message,
    // required this.paymentState,
  });

  factory PaymentViewState.initial() {
    return PaymentViewState(
      paymentModel: PaymentModel(
        data: Data(),
        message: '',
        status: false,
      ),
      loadState: NetworkState.loading,
      message: null,
      // paymentState: PaymentState.idle,
    );
  }

  PaymentViewState copyWith({
    NetworkState? loadState,
    PaymentModel? paymentModel,
    String? message,
    PaymentState? paymentState,
  }) {
    return PaymentViewState(
      loadState: loadState ?? this.loadState,
      paymentModel: paymentModel ?? this.paymentModel,
      message: message ?? this.message,
      // paymentState: paymentState ?? this.paymentState,
    );
  }
}

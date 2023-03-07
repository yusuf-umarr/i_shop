// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:i_shop_riverpod/core/utils/enums.dart';


class OrderState {
  final NetworkState loadState;
  final List<dynamic> orderList;
  final String? message;

  OrderState({
    required this.loadState,
    required this.orderList,
    required this.message,
  });

  factory OrderState.initial() {
    return OrderState(
      orderList: [],
      loadState: NetworkState.loading,
      message: null,
    );
  }

  

  OrderState copyWith({
    NetworkState? loadState,
    List<dynamic>? orderList,
    String? message,
  }) {
    return OrderState(
      loadState: loadState ?? this.loadState,
      orderList: orderList ?? this.orderList,
      message: message ?? this.message,
    );
  }
}

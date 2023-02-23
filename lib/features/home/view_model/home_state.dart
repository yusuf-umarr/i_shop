
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/account/model/product_model.dart';

class DealofDayState {
   final NetworkState loadState;
  final ProductModel dealOfDayProduct;
  final String? message;
  DealofDayState({
    required this.loadState,
    required this.dealOfDayProduct,
    required this.message,
  });

   
  factory DealofDayState.initial() {
    return DealofDayState(
      dealOfDayProduct: ProductModel(
        id: "",
        name: "",
        description: "",
        images: [],
        quantity: null,
        price: null,
        category: "",
        ratings: [],
        v: null,
    ),
      loadState: NetworkState.loading,
      message: null,
    );
  }




  DealofDayState copyWith({
    NetworkState? loadState,
    ProductModel? dealOfDayProduct,
    String? message,
  }) {
    return DealofDayState(
      loadState: loadState ?? this.loadState,
      dealOfDayProduct: dealOfDayProduct ?? this.dealOfDayProduct,
      message: message ?? this.message,
    );
  }
}

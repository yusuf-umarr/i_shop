// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/account/model/product_deal_day.dart';
import 'package:i_shop_riverpod/features/account/model/product_model.dart';

class ProductCategoryState {
   final NetworkState loadState;
  final List<dynamic> productCategory;
  final String? message;
  ProductCategoryState({
    required this.loadState,
    required this.productCategory,
    required this.message,
  });

   
  factory ProductCategoryState.initial() {
    return ProductCategoryState(
      productCategory:[],
      loadState: NetworkState.loading,
      message: null,
    );
  }




 

  ProductCategoryState copyWith({
    NetworkState? loadState,
    List<dynamic>? productCategory,
    String? message,
  }) {
    return ProductCategoryState(
      loadState: loadState ?? this.loadState,
      productCategory: productCategory ?? this.productCategory,
      message: message ?? this.message,
    );
  }
}

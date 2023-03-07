import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/config/exception/app_exception.dart';
import 'package:i_shop_riverpod/core/config/response/api_response.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/home/services/home_provider.dart';

abstract class CartRepository {
  Future<ApiResponse<dynamic>> postOrderProduct( cartProducts);
}

class CartRepositoryImpl implements CartRepository {
  final Dio _dio;

  CartRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<dynamic>> postOrderProduct( cartProducts) async {
    try {
      final response = await _dio.post(postOrderPath, data: {
        "cartProducts": cartProducts,
     
      });

      // List<dynamic> productCate =
      //     response.data.map((e) => ProductModel.fromJson(e)).toList();

      print("==============response.data====================");
      print(response.data);

      return ApiResponse<dynamic>(
        success: true,
        data: response.data,
        message: "products fetched successfully",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final cartRepository = Provider<CartRepository>(
  (ref) => CartRepositoryImpl(
    ref.read(dioProvider),
  ),
);

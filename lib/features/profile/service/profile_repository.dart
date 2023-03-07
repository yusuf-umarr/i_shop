import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/config/exception/app_exception.dart';
import 'package:i_shop_riverpod/core/config/response/api_response.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/home/services/home_provider.dart';
import 'package:i_shop_riverpod/features/profile/models/get_order_model.dart';
import 'package:i_shop_riverpod/features/profile/models/my_order_model.dart';

abstract class ProfileRepository {
  Future<ApiResponse<List<dynamic>>> fetchOrderedProduct();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final Dio _dio;

  ProfileRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<List<dynamic>>> fetchOrderedProduct() async {
    try {
      final response = await _dio.get(getOrderPath);

      List<dynamic> orderedProduct =
          response.data.map((e) => MyOrderModel.fromJson(e)).toList();

      return ApiResponse<List<dynamic>>(
        success: true,
        data: orderedProduct,
        message: "products fetched successfully",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final profileRepository = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(
    ref.read(dioProvider),
  ),
);

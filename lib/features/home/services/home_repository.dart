import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/config/exception/app_exception.dart';
import 'package:i_shop_riverpod/core/config/response/api_response.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/home/services/home_provider.dart';
import 'package:i_shop_riverpod/features/product_category/models/product_model.dart';

abstract class HomeRepository {
  Future<ApiResponse<ProductModel>> fetchDealOfDay();
}

class HomeRepositoryImpl implements HomeRepository {
  final Dio _dio;

  HomeRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<ProductModel>> fetchDealOfDay() async {
    try {
      final response = await _dio.get(
        dealOdDayPath,
      );
      ProductModel dealOfDay = ProductModel.fromJson(response.data);
      return ApiResponse<ProductModel>(
        success: true,
        data: dealOfDay,
        message: "deal fetched successfully",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final homeRepository = Provider<HomeRepository>(
  (ref) => HomeRepositoryImpl(
    ref.read(dioProvider),
  ),
);

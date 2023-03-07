import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/config/exception/app_exception.dart';
import 'package:i_shop_riverpod/core/config/response/api_response.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/account/model/product_model.dart';
import 'package:i_shop_riverpod/features/home/services/home_provider.dart';

abstract class CategoryRepository {
  Future<ApiResponse<List<dynamic>>> fetchProductByCategory(String category);
  Future<ApiResponse<List<dynamic>>> fetchAlProductByCategory();
}

class CategoryRepositoryImpl implements CategoryRepository {
  final Dio _dio;

  CategoryRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<List<dynamic>>> fetchProductByCategory(
      String category) async {
    try {
      final response = await _dio
          .get(productCategoryPath, queryParameters: {"category": category});

      List<dynamic> productCate =
          response.data.map((e) => ProductModel.fromJson(e)).toList();

      // print(productCate);

      return ApiResponse<List<dynamic>>(
        success: true,
        data: productCate,
        message: "products fetched successfully",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<ApiResponse<List<dynamic>>> fetchAlProductByCategory() async {
    try {
      final response = await _dio.get(allProductCategoryPath);

      List<dynamic> productCate =
          response.data.map((e) => ProductModel.fromJson(e)).toList();

      return ApiResponse<List<dynamic>>(
        success: true,
        data: productCate,
        message: "products fetched successfully",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final categoryRepository = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(
    ref.read(dioProvider),
  ),
);

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/config/exception/app_exception.dart';
import 'package:i_shop_riverpod/core/config/response/api_response.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/home/services/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future<ApiResponse<UserModel>> login(UserModel model);
  Future<ApiResponse<UserModel>> register(UserModel model);
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<UserModel>> login(UserModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await _dio.post(loginPath,
          data: {"email": model.email, "password": model.password,});
      UserModel userModel = UserModel.fromJson(response.data);

      await prefs.setString('x-auth-token', "${userModel.token}");

      return ApiResponse<UserModel>(
        success: true,
        data: userModel,
        message: "login successfully!!!",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<ApiResponse<UserModel>> register(UserModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await _dio.post(registerPath, data: {
        "name": model.name,
        "email": model.email,
        "password": model.password,
      });
      UserModel userModel = UserModel.fromJson(response.data);

      await prefs.setString('x-auth-token', "${userModel.token}");

      return ApiResponse<UserModel>(
        success: true,
        data: userModel,
        message: "Register successfully!!!",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final authRepository = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(dioProvider),
  ),
);

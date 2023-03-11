import 'package:cloudinary_public/cloudinary_public.dart';
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
  Future<ApiResponse<UserModel>> updateAddress(String address);
  Future<ApiResponse<UserModel>> updateUser(UserModel model);
  Future<ApiResponse<UserModel>> getUserData();
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<UserModel>> login(UserModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await _dio.post(loginPath, data: {
        "email": model.email,
        "password": model.password,
      });
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

  @override
  Future<ApiResponse<UserModel>> updateAddress(String userAddress) async {
    try {
      final response = await _dio.post(addressPath, data: {
        "address": userAddress,
      });

      UserModel userModel = UserModel.fromJson(response.data);

      return ApiResponse<UserModel>(
        success: true,
        data: userModel,
        message: "Address updated successfully!!!",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<ApiResponse<UserModel>> updateUser(UserModel model) async {
    var pic = model.profilePic;

    final cloudinary = CloudinaryPublic('dikcipece', 'sgcnowwa');
    var imageUrls;

    if (pic.runtimeType == String) {
      imageUrls = await model.profilePic;
    } else {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(model.profilePic.path, folder: model.name),
      );
      imageUrls = await res.secureUrl;
    }

    try {
      final response = await _dio.post(updateUserPath, data: {
        "name": model.name,
        "email": model.email,
        "address": model.address,
        "password": model.password,
        "profilePic": imageUrls,
      });

      UserModel userModel = UserModel.fromJson(response.data);

      return ApiResponse<UserModel>(
        success: true,
        data: userModel,
        message: "Address updated successfully!!!",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<ApiResponse<UserModel>> getUserData() async {
    try {
      var userRes;

      Response<bool> tokenRes = await _dio.post(validateTokenPath);

      if (tokenRes.data == true) {
        userRes = await _dio.get(getUserPath);
      }

      UserModel userModel = UserModel.fromJson(userRes.data);

      return ApiResponse<UserModel>(
        success: true,
        data: userModel,
        message: "user data fetched successful",
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

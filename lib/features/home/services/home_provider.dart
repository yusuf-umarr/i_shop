import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/utils/interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
   dio.options.baseUrl = baseUrl;
  dio.interceptors.add(AppInterceptor());
  return dio;
});

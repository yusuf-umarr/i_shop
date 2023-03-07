import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/config/exception/app_exception.dart';
import 'package:i_shop_riverpod/core/config/response/api_response.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/payment/model/payment_model.dart';
import 'package:i_shop_riverpod/features/home/services/home_provider.dart';

abstract class PaymentRepository {
  Future<ApiResponse<PaymentModel>> checkOut(String email, String ammount);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final Dio _dio;

  PaymentRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<PaymentModel>> checkOut(
      String email, String amount) async {
    try {
      final response = await _dio.post(initializedUrl, data: {
        "email": email,
        "amount": amount,
      },
      );

      PaymentModel paymentModel = PaymentModel.fromJson(response.data);

      return ApiResponse<PaymentModel>(
        success: true,
        data: paymentModel,
        message: "Payment redirect",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final paymentRepository = Provider<PaymentRepository>(
  (ref) => PaymentRepositoryImpl(
    ref.read(dioProvider),
  ),
);

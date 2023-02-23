import 'package:dio/dio.dart';
import 'package:i_shop_riverpod/core/config/helpers/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
       SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
    // options.queryParameters["apiKey"] = AuthStrings.apiKey; 
    options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token':
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZTBlYzA4OTE5ZGJlZGQ3NjE3ZWM2NSIsImlhdCI6MTY1ODkwODU2Mn0.dIs1dpzQU3U1NvjsaYJlsRqy2310JXfsrwUtrOi94UI",
    };
    options.sendTimeout = 30000;
    // debugLog(options.baseUrl + options.path);
    // debugLog(options.headers);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode! >= 200) {
      debugLog("Yes completed");
    }
    return super.onResponse(response, handler);
  }
}

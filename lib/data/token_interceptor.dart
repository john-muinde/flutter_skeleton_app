import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      // Handle the case where the server responded with a 401 status code
      // This usually means the token is expired
      // You can refresh the token here and retry the request
    }

    super.onResponse(response, handler);
  }
}

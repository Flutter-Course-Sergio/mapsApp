import 'package:dio/dio.dart';

import '../config/config.dart';

class PlacesInterceprot extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'limit': 7,
      'language': 'es',
      'access_token': Environment.mapboxKey,
    });

    super.onRequest(options, handler);
  }
}

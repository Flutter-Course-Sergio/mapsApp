import 'package:dio/dio.dart';

import '../config/config.dart';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': Environment.mapboxKey,
    });

    super.onRequest(options, handler);
  }
}

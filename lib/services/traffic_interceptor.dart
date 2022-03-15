import 'package:appprueba/config/config_app.dart';
import 'package:dio/dio.dart';


class TrafficInterceptor extends Interceptor {

  final accessToken = ConfigApp.APY_KEY_MAPBOOX;
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'alternatives': false,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': true,
      'access_token': accessToken
    });


    super.onRequest(options, handler);
  }


}

import 'package:dio/dio.dart';

import 'custom_interceptor.dart';

class DioClient{
  Dio dio = Dio();
  DioClient(){
    dio.interceptors.add(
      CustomInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }


}
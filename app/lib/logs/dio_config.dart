// dio_config.dart
import 'package:dio/dio.dart';
import 'logging_interceptor.dart'; // Import LoggingInterceptor bạn đã tạo

Dio createDio() {
  Dio dio = Dio();
  dio.interceptors.add(LoggingInterceptor()); // Thêm interceptor để log request và response
  return dio;
}

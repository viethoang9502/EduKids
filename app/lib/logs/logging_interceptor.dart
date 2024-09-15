import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Request sent: ${options.method} ${options.uri}');
    print('Headers: ${options.headers}');
    print('Body: ${options.data}');
    handler.next(options);  // Cho phép yêu cầu tiếp tục
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response received: ${response.statusCode} ${response.data}');
    handler.next(response);  // Cho phép phản hồi tiếp tục
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('Error: ${err.type} ${err.message}');
    handler.next(err);  // Cho phép lỗi được xử lý tiếp
  }

  Dio createDio() {
    Dio dio = Dio();
    dio.interceptors.add(LoggingInterceptor());
    return dio;
  }

}

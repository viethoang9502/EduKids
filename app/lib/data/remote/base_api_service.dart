import 'package:dio/dio.dart';

abstract class BaseApiService {
  static get baseUrl => "https://gdtth.ibme.edu.vn/api/v1";

  final Dio dio = Dio();

  Future<dynamic> get({required String url});
  Future<dynamic> post({required String url, dynamic data});
  Future<dynamic> put({required String url, dynamic data});
  Future<dynamic> delete({required String url});
}

import '../data/remote/api_endpoint.dart';
import '../models/auth/auth_model.dart';
import '../services/network_api_service.dart';

abstract class AuthRepository {
  Future<AuthModel> login(
      {required String phone_number, required String password});
  Future<void> logOut();
  Future<dynamic> register({
    required String fullname,
    required String phone_number,
    required String address,
    required String password,
    required String retype_password,
    required String date_of_birth,
  });
}

class AuthRepositoryImpl extends AuthRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  @override
  Future<AuthModel> login(
      {required String phone_number, required String password}) async {
    Map<String, String> data = {
      "phone_number": phone_number,
      "password": password,
    };

    try {
      dynamic response =
          await _apiServices.post(url: ApiEndPoint.login, data: data);
      return AuthModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logOut() {
    throw UnimplementedError();
  }

  @override
  Future register({
    required String fullname,
    required String phone_number,
    required String address,
    required String password,
    required String retype_password,
    required String date_of_birth,
  }) async {
    Map<String, dynamic> data = {
      "fullname": fullname,
      "phone_number": phone_number,
      "address": address,
      "password": password,
      "retype_password": retype_password,
      "date_of_birth": date_of_birth,
      "facebook_account_id": 0,
      "google_account_id": 0,
      "role_id": 1,
    };
    try {
      dynamic response =
          await _apiServices.post(url: ApiEndPoint.register, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

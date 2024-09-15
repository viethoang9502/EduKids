import '../data/remote/api_endpoint.dart';
import '../models/auth/user_model.dart';
import '../services/network_api_service.dart';

abstract class UserRepository {
  UserModel? _profile;
  UserModel? get profile => _profile;

  Future<UserModel> getProfile(); // Abstract method to get user profile
}

class UserRepositoryImpl extends UserRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  @override
  Future<UserModel> getProfile() async {
    try {
      if (_profile == null) { // Fetch profile only if not already fetched
        dynamic response = await _apiServices.post(url: ApiEndPoint.userDetail); // API call to fetch user details
        _profile = UserModel.fromJson(response); // Parse the response to UserModel
      }
      return _profile!;
    } catch (e) {
      rethrow; // Rethrow the error to be handled by the caller
    }
  }
}

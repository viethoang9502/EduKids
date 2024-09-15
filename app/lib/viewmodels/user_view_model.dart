import 'package:flutter/material.dart';

import '../models/auth/user_model.dart';
import '../repository/user_repository.dart';
import 'base_view_model.dart';

class UserViewModel extends BaseViewModel {
  final UserRepository userRepository;

  UserViewModel({required this.userRepository});

  UserModel? userModel; // Nullable UserModel

  @override
  void onInitView(BuildContext context) {
    getUser().then((user) {
      if (user != null) {
        userModel = user;
        notifyListeners(); // Notify listeners after data is fetched
      }
    }).catchError((error) {
      print('Error fetching user data: $error'); // Log the error
    });

    super.onInitView(context);
  }


  Future<UserModel?> getUser() async {
    try {
      UserModel fetchedUser = await userRepository.getProfile();
      return fetchedUser; // Return the fetched user
    } catch (e) {
      print('Error in getUser: $e'); // Log the error
      return null; // Return null in case of an error
    }
  }

}

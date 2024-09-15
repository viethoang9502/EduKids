
import 'package:flutter/material.dart';

import '../repository/auth_repository.dart';
import '../res/constant/app_assets.dart';
import '../utils/general_utils.dart';
import '../utils/log_utils.dart';
import '../utils/validators.dart';
import 'base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthRepository authRepository;
  RegisterViewModel({required this.authRepository});

  bool _isSecurePassword = true;
  bool get isSecurePassword => _isSecurePassword;

  String fullname = "";
  String phone_number = "";
  String address = "Đây là User";
  String password = "";
  String retype_password = "";
  String date_of_birth = "";
  bool get isRegisterButtonEnabled {
    return !Validators.isEmpty(fullname) &&
        !Validators.isEmpty(phone_number) &&
        !Validators.isEmpty(password) &&
        !Validators.isEmpty(retype_password);
  
  }

  void toggleShowHidePassword() {
    _isSecurePassword = !_isSecurePassword;
    updateUI();
  }
  void onUsernameChange(String value) {
    fullname = value.trim();
    updateUI();
  }

   void onPasswordChange(String value) {
    password = value.trim();

    updateUI();
  }

  void onPasswordConfirmChange(String value) {
    retype_password = value.trim();

    updateUI();
  }


  void onPhoneChange(String value) {
    phone_number = value.trim();

    updateUI();
  }


  void registerNewAccount() async {
    
    Utils.showProgressingDialog(context, message: "Loading...");
    try {
      final resp = await authRepository.register(
        fullname: fullname,
        phone_number: phone_number,
        address: "Đây là user",
        password: password,
        retype_password: retype_password,
        date_of_birth: "2000-10-25",     
      );
      if (!context.mounted) return;
      Utils.hideProgressDialog(context);
      Utils.showPopup(
        onTap: () => Navigator.pop(context),
        context,
        icon: AppAssets.icDown,
        title: "Đăng ký thành công ",
        message: "!",
      );

      
    } catch (e) {
      Utils.hideProgressDialog(context);
      Utils.showToast(message: e.toString());
    }
  }


}

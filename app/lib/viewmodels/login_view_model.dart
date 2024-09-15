import 'package:flutter/material.dart';

import '../data/remote/api_exception.dart';
import '../models/auth/auth_model.dart';
import '../repository/auth_repository.dart';
import '../res/constant/app_assets.dart';
import '../res/enum/validate_state.dart';
import '../res/enum/view_state.dart';
import '../services/shared_pref_service.dart';
import '../utils/general_utils.dart';
import '../utils/log_utils.dart';
import '../utils/routes/routes.dart';
import '../utils/string_utils.dart';
import '../utils/validators.dart';
import '../view/home/home_screen.dart';
import 'base_view_model.dart';


class LoginViewModel extends BaseViewModel {
  final AuthRepository authRepository;
  LoginViewModel({required this.authRepository});
 
  bool _securePassword = true;

  bool get securePassword => _securePassword;

  void obscurePassword(bool value) {
    _securePassword = value;
    setState(ViewState.success);
  }

  String _email = "";

  void onEmailChange(String value) {
    _email = value.trim();
    setState(ViewState.success);
  }

  String _password = "";

  void onPasswordChange(String value) {
    _password = value.trim();
    setState(ViewState.success);
  }

  bool get isLoginButtonEnabled {
    return !Validators.isEmpty(_password) && !Validators.isEmpty(_email);
  }

  ValidateEmailState _validateEmailState = ValidateEmailState.none;

  ValidateEmailState get validateEmailState => _validateEmailState;

  void restoreValidateEmailState() {
    _validateEmailState = ValidateEmailState.none;
    setState(ViewState.success);
  }

  ValidatePasswordState _validatePasswordState = ValidatePasswordState.none;

  ValidatePasswordState get validatePasswordState => _validatePasswordState;

  void restoreValidatePasswordState() {
    _validatePasswordState = ValidatePasswordState.none;
    updateUI();
  }

  void onLoginBtnPressed() async {
    if (!Validators.isValidPassword(_password)) {
      _validatePasswordState = ValidatePasswordState.invalid;
      updateUI();
      return;
    }

    Utils.showProgressingDialog(context, message: "Loading...");

    try {
      final AuthModel resp = await authRepository.login(
          phone_number: _email.trim(), password: _password.trim());

      await Future.wait([
        SharedPrefService.instance.setUserToken(userToken: resp.token),

      ]);
    if (!context.mounted) return;
      Utils.hideProgressDialog(context);

      goToHomeScreen();

    } on BadRequestException catch (e) {
      LogUtils.d("NotFoundException");
      Utils.hideProgressDialog(context);
      Utils.showPopup(
        onTap: () => Navigator.pop(context),
        context,
        icon: AppAssets.icDown,
        title: "Đăng nhập thất bại",
        message: "Mật khẩu của bạn không đúng.\nHãy kiểm tra lại!",
      );
    } on NotFoundException catch (e) {
      LogUtils.d(e.message!);
      Utils.hideProgressDialog(context);

      String title = '';
      String message = '';
      switch (e.message) {
        case 'UserNotVerify':
          title = "Tài khoản chưa xác thực";
          message =
              "Tài khoản của bạn chưa được xác thực.\nHãy kiểm tra email để xác thực tài khoản!";
          break;
        default:
          title = "Tài khoản không tồn tại";
          message = "Tài khoản của bạn không tồn tại.\nHãy kiểm tra lại!";
          break;
      }

      Utils.showPopup(
        onTap: () => Navigator.pop(context),
        context,
        icon: AppAssets.icDown,
        title: title,
        message: message,
      );
    } on UnauthorizedException {
      LogUtils.d("NotFoundException");
      Utils.hideProgressDialog(context);
      Utils.showPopup(
        onTap: () => Navigator.pop(context),
        context,
        icon: AppAssets.icDown,
        title: "Đăng nhập thất bại",
        message: "Mật khẩu của bạn không đúng.\nHãy kiểm tra lại!",
      );
    } catch (e) {
      LogUtils.d(e.toString());
      Utils.hideProgressDialog(context);
      Utils.showToast(message: e.toString());
    }
  }


  void goToRegisterScreen() {
    Routes.goToRegisterScreen(context);
  }

  void goToHomeScreen() {
    Routes.goToHomeScreen(context);
  }

}

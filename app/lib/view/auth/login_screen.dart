import 'package:Edukids/view/auth/forgot_password_screen.dart';
import 'package:Edukids/view/auth/register_screen.dart';
import 'package:Edukids/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../repository/auth_repository.dart';
import '../../res/constant/app_assets.dart';
import '../../res/enum/validate_state.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/string_utils.dart';
import '../../viewmodels/login_view_model.dart';
import '../widget/ui_button.dart';
import '../widget/ui_text.dart';
import '../widget/ui_textinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginViewModel viewModel;

  @override
  void initState() {
    viewModel = LoginViewModel(authRepository: locator<AuthRepository>())
      ..onInitView(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.yellowColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: DimensManager.dimens.indicatorBarHeight,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: AppColors.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: DimensManager.dimens.setHeight(40),
                    ),
                    _buildLogo(),
                    SizedBox(
                      height: DimensManager.dimens.setHeight(15),
                    ),
                    UIText(
                      "VUI LÒNG ĐĂNG NHẬP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: DimensManager.dimens.setSp(25),
                      ),
                    ),
                    SizedBox(
                      height: DimensManager.dimens.setHeight(16),
                    ),
                    Selector<LoginViewModel, ValidateEmailState>(
                      builder: (_, validateEmailState, __) {
                        return UITextInput(
                          title: "Tài khoản",
                          hint: "Email hoặc SĐT đã đăng ký",
                          errorMessage: StringUtils.toInvalidEmailString(
                              validateEmailState, context),
                          onFocus: viewModel.restoreValidateEmailState,
                          onChanged: viewModel.onEmailChange,
                        );
                      },
                      selector: (_, viewModel) => viewModel.validateEmailState,
                    ),
                    SizedBox(height: DimensManager.dimens.setHeight(10)),
                    Selector<LoginViewModel, bool>(
                      builder: (_, securePassword, __) {
                        return Selector<LoginViewModel, ValidatePasswordState>(
                          builder: (_, state, __) {
                            return UITextInput(
                              title: "Mật khẩu",
                              hint: "Nhập mật khẩu",
                              isObscure: securePassword,
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: viewModel.onPasswordChange,
                              onFocus: viewModel.restoreValidatePasswordState,
                              onSuffixIconPressed: () {
                                viewModel.obscurePassword(!securePassword);
                              },
                              errorMessage: StringUtils.toInvalidPasswordString(
                                  state, context),
                            );
                          },
                          selector: (_, viewModel) =>
                              viewModel.validatePasswordState,
                        );
                      },
                      selector: (_, viewModel) => viewModel.securePassword,
                    ),
                    SizedBox(height: DimensManager.dimens.setHeight(18)),
                    _buildForgotPassword(),
                  ],
                ),
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(32),
              ),
              UIButton(
                onTap: () {
                  viewModel.onLoginBtnPressed();
                },
                child: UIText(
                  "ĐĂNG NHẬP",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: DimensManager.dimens.setSp(16),
                    // height: 24,
                  ),
                ),
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(16),
              ),
              // UIButton(
              //   onTap: () {},
              //   child: UIText(
              //     "MUA NGAY",
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //       fontSize: DimensManager.dimens.setSp(16),
              //       // height: 24,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: DimensManager.dimens.setHeight(16),
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: DimensManager.dimens.setHeight(20)),
                child: _buildRegisterAccount(),
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(24),
              )
            ],
          ),
        ),
      ),
    );
  }

  Image _buildLogo() {
    return Image.asset(
      AppAssets.logo,
      width: DimensManager.dimens.setWidth(179.69),
      height: DimensManager.dimens.setHeight(150),
    );
  }

  Widget _buildForgotPassword() {
    return Padding(
      padding: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(8)),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
        ),
        child: Text(
          // Strings.of(context).forgotPassword,
          "Quên mật khẩu?",
          style: TextStyle(
              color: Colors.white,
              fontSize: DimensManager.dimens.setSp(16),
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildRegisterAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Thành viên mới?",
          style: TextStyle(
            color: AppColors.contentTextColor,
            fontSize: DimensManager.dimens.setSp(16),
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
            // _signInViewModel.navigateToSignUpScreen();
          },
          borderRadius:
              BorderRadius.circular(DimensManager.dimens.setRadius(4)),
          child: Padding(
            padding: EdgeInsets.all(DimensManager.dimens.setRadius(4)),
            child: Text(
              "Đăng ký ngay",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
                fontSize: DimensManager.dimens.setSp(16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

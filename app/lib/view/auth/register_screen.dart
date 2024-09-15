import 'package:Edukids/view/widget/ui_button.dart';
import 'package:Edukids/view/widget/ui_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../repository/auth_repository.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../viewmodels/register_view_model.dart';
import '../widget/ui_text.dart';
import '../widget/ui_textinput.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterViewModel viewModel;

  @override
  void initState() {
    viewModel = RegisterViewModel(authRepository: locator<AuthRepository>())
      ..onInitView(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: const UIText(
            "Đăng ký tài khoản",
            color: Colors.white,
            size: 18,
          ),
          elevation: 0,
        ),
        body: Container(
          color: AppColors.bgColor,
          margin: EdgeInsets.only(
            bottom: DimensManager.dimens.indicatorBarHeight,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: DimensManager.dimens.setHeight(16),
                ),
                UITextInput(
                  hint: "Họ tên *",
                  onChanged: viewModel.onUsernameChange,
                ),
                SizedBox(
                  height: DimensManager.dimens.setHeight(24),
                ),
                 UITextInput(
                  hint: "Số điện thoại *",
                  onChanged: viewModel.onPhoneChange
                ),
                SizedBox(
                  height: DimensManager.dimens.setHeight(24),
                ),
                const UITextInput(
                  hint: "Email",
                ),
                SizedBox(
                  height: DimensManager.dimens.setHeight(24),
                ),
                 UITextInput(
                  hint: "Mật khẩu *",
                  isObscure: true,
                  onChanged: viewModel.onPasswordChange,
                ),
                SizedBox(
                  height: DimensManager.dimens.setHeight(24),
                ),
                 UITextInput(
                  isObscure: true,
                  hint: "Xác nhận mật khẩu *",
                  onChanged: viewModel.onPasswordConfirmChange,

                ),
                SizedBox(
                  height: DimensManager.dimens.setHeight(24),
                ),
                // const UITextInput(
                //   hint: "Ngày sinh *",
                // ),
                // SizedBox(
                //   height: DimensManager.dimens.setHeight(24),
                // ),
                // const UITextInput(
                //   hint: "Giới tính *",
                // ),
                // SizedBox(
                //   height: DimensManager.dimens.setHeight(24),
                // ),
                // const UITextInput(
                //   hint: "Chọn Tỉnh/Thành *",
                // ),
                _buildAgreeLicences(),
                _buildAgreeNotify(),
                SizedBox(
                  height: DimensManager.dimens.setHeight(16),
                ),
                Selector<RegisterViewModel, bool>(
                  selector: (_, viewModel) => viewModel.isRegisterButtonEnabled,
                  builder: (_, isEnabled, __) => UIOutlineButton(
                    backgroundColor: AppColors.primaryColor,
                    title: "ĐĂNG KÝ TÀI KHOẢN",
                    titleStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    onPressed: viewModel.registerNewAccount,
                  ),
                ),

                SizedBox(
                  height: DimensManager.dimens.setHeight(16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildAgreeLicences() {
  return Padding(
    padding: EdgeInsets.only(top: DimensManager.dimens.setHeight(16)),
    child: FittedBox(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(2)),
            child: SizedBox(
              height: DimensManager.dimens.setHeight(16),
              child: Checkbox(
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: true,
                onChanged: (value) {},
              ),
            ),
          ),
          const Text(
            "Đồng ý với ",
            style: TextStyle(fontSize: 14),
          ),
          const Text(
            "Chính sách quy định chung và bảo mật",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
                decoration: TextDecoration.underline),
          )
        ],
      ),
    ),
  );
}

Widget _buildAgreeNotify() {
  return Padding(
    padding: EdgeInsets.only(top: DimensManager.dimens.setHeight(16)),
    child: FittedBox(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(2)),
            child: SizedBox(
              height: DimensManager.dimens.setHeight(16),
              child: Checkbox(
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: true,
                onChanged: (value) {},
              ),
            ),
          ),
          const Text(
            "Nhận chương trình khuyến mãi qua email ",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}

import 'package:Edukids/view/widget/ui_button.dart';
import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../widget/ui_text.dart';
import '../widget/ui_textinput.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            top: DimensManager.dimens.statusBarHeight,
            bottom: DimensManager.dimens.indicatorBarHeight,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(41),
              ),
              UIText(
                "QUÊN MẬT KHẨU",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: DimensManager.dimens.setSp(20),
                    color: Colors.white),
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(24),
              ),
              UIText(
                "Vui lòng nhập số điện thoại bên dưới để lấy lại mật khẩu",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: DimensManager.dimens.setSp(16),
                    color: Colors.white),
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(48),
              ),
              const UITextInput(
                hint: "Số điện thoại *",
              ),
              SizedBox(height: DimensManager.dimens.setHeight(28)),
              UIButton(
                onTap: () {},
                color: Colors.yellow,
                child: UIText(
                  "GỬI THÔNG TIN",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: DimensManager.dimens.setSp(16),
                    // height: 24,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

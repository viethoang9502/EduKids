import 'package:Edukids/res/style/app_colors.dart';
import 'package:Edukids/view/widget/ui_appbar.dart';
import 'package:Edukids/view/widget/ui_text.dart';
import 'package:flutter/material.dart';

class RencentOrderScreen extends StatefulWidget {
  const RencentOrderScreen({Key? key}) : super(key: key);

  @override
  _RencentOrderScreenState createState() => _RencentOrderScreenState();
}

class _RencentOrderScreenState extends State<RencentOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: UiAppBar(title:  "ĐƠN HÀNG GẦN ĐÂY"),
      body: const Align(
          alignment: Alignment.topCenter,
          child: UIText(
            "Hiện chưa có đơn hàng nào",
            fontWeight: FontWeight.w300,
          )),
    );
  }
}

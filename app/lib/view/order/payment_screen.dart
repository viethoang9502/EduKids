import 'package:Edukids/repository/order_repository.dart';
import 'package:Edukids/repository/lesson_repository.dart';
import 'package:Edukids/repository/user_repository.dart';
import 'package:Edukids/viewmodels/order_view_model.dart';
import 'package:Edukids/viewmodels/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Edukids/res/style/app_colors.dart';
import 'package:Edukids/view/widget/ui_button.dart';
import 'package:Edukids/view/widget/ui_text.dart';
import '../../locator.dart';
import '../../res/constant/app_assets.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/general_utils.dart';
import '../../utils/validators.dart';
import '../widget/ui_textinput.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key, required this.total}) : super(key: key);
  double total;
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late OrderViewModel orderViewModel;
  late ProductViewModel productViewModel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  bool _areFieldsFilled() {
    return nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        addressController.text.isNotEmpty;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    productViewModel =
        ProductViewModel(productRepository: locator<ProductRepository>())
          ..onInitView(context);
    orderViewModel = OrderViewModel(
        userRepository: locator<UserRepository>(),
        orderRepository: locator<OrderRepository>(),
        productViewModel: productViewModel)
      ..onInitView(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productViewModel,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const UIText(
            "THANH TOÁN",
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: DimensManager.dimens.setHeight(16),
              ),
              UITextInput(
                controller: nameController,
                hint: "Họ tên *",
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(24),
              ),
              UITextInput(
                controller: phoneController,
                hint: "Số điện thoại *",
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(24),
              ),
              UITextInput(
                controller: addressController,
                hint: "Địa chỉ *",
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(24),
              ),
              UITextInput(
                controller: noteController,
                hint: "Ghi chú",
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: UIText(
                  "Thanh toán khi nhận hàng",
                ),
              ),
              _buildBottomSheet(widget.total),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(double total) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const UIText("TỔNG CỘNG:"),
                  UIText(
                    Validators.formatCurrency(total),
                  ),
                ],
              ),
            ),
            UIButton(
              onTap: () {
                if (_areFieldsFilled()) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Xác nhận"),
                      content: const Text("Đặt hàng thành công!"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            orderViewModel.postOrder(
                                name: nameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                note: noteController.text,
                                money: total);
                            productViewModel.clearCart();
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                            Utils.showPopup(
                              onTap: () => Navigator.pop(context),
                              context,
                              icon: AppAssets.icChicken1,
                              title: "Bạn đã đặt hàng thành công",
                              message:
                                  "Hệ thống đã ghi nhận đơn đặt hàng của bạn!",
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bạn phải điền đầy đủ thông tin'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const UIText(
                "ĐẶT NGAY",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

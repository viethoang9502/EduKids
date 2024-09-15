import 'package:Edukids/services/shared_pref_service.dart';
import 'package:Edukids/utils/validators.dart';
import 'package:Edukids/view/order/payment_screen.dart';
import 'package:Edukids/viewmodels/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Edukids/res/style/app_colors.dart';
import 'package:Edukids/view/widget/ui_button.dart';
import 'package:Edukids/view/widget/ui_text.dart';
import 'package:Edukids/view/widget/ui_product_order.dart';

import '../../locator.dart';
import '../../repository/lesson_repository.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late ProductViewModel viewModel;
  @override
  void initState() {
    viewModel =
        ProductViewModel(productRepository: locator<ProductRepository>())
          ..onInitView(context);
    super.initState();
    viewModel.fetchCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ProductViewModel>(
        builder: (context, value, child) => Scaffold(
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
              "ĐANG HỌC",
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Column(
            children: [
              viewModel.listProductOrder.isEmpty
                  ? const Expanded(
                      child: Center(
                          child: UIText(
                              "Hiện chưa có bài nào đang học.")),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: viewModel.listProductOrder.length,
                        itemBuilder: (context, index) {
                          final item = viewModel.listProductOrder[index];
                          print(item);
                          return UiProductOrder(
                            title: item.name,
                            image: item.thumbnail,
                            price: Validators.formatCurrency(item.price),
                            description: item.description,
                            quantity: item.quantity,
                            onDelete: () =>
                                viewModel.removeProductFromCart(item.id),
                            onIncrement: () =>
                                viewModel.incrementQuantity(item.id),
                            onDecrement: () =>
                                viewModel.decrementQuantity(item.id),
                          );
                        },
                      ),
                    ),
              // _buildBottomSheet(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildBottomSheet() {
  //   return ChangeNotifierProvider.value(
  //     value: viewModel,
  //     child: Padding(
  //       padding: const EdgeInsets.only(bottom: 9.0),
  //       child: Align(
  //         alignment: Alignment.bottomCenter,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const UIText("TỔNG CỘNG:"),
  //                   Consumer<ProductViewModel>(
  //                     builder: (context, viewModel, child) => UIText(
  //                       Validators.formatCurrency(viewModel.totalCartAmount),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             UIButton(
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => PaymentScreen(
  //                             total: viewModel.totalCartAmount,
  //                           )),
  //                 );
  //               },
  //               child: const UIText(
  //                 "MUA NGAY",
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

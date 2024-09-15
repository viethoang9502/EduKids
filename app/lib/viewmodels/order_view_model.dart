import 'package:Edukids/locator.dart';
import 'package:Edukids/repository/order_repository.dart';
import 'package:Edukids/repository/user_repository.dart';
import 'package:Edukids/viewmodels/base_view_model.dart';
import 'package:Edukids/viewmodels/product_view_model.dart';
import 'package:flutter/material.dart';

import '../models/order/order_model.dart';

class OrderViewModel extends BaseViewModel {
  final OrderRepository orderRepository;
  final UserRepository userRepository;
  final ProductViewModel productViewModel;
  OrderViewModel(
      {required this.orderRepository,
      required this.userRepository,
      required this.productViewModel});

  @override
  void onInitView(BuildContext context) {
    locator<UserRepository>().getProfile();
    super.onInitView(context);
  }

  Future postOrder(
      {required String name,
      required String phone,
      required String address,
      required String note,
      required double money}) async {
    try {
      productViewModel.fetchCartProducts();
      List<CartItem> cartItems = productViewModel.listProductOrder
          .map((item) => CartItem(
                productId: item.id,
                quantity: item.quantity,
              ))
          .toList();
      await orderRepository.postOrder(
          userId: userRepository.profile?.id.toString() ?? "",
          email: "nvxx@yahoo.com",
          fullname: name,
          address: address,
          note: note,
          totalMoney: money,
          phoneNumber: phone,
          paymentMethod: "cod",
          shippingMethod: "express",
          cartItems: cartItems);
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
  }
}

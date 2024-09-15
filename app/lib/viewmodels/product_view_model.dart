import 'package:Edukids/locator.dart';
import 'package:Edukids/repository/lesson_repository.dart';
import 'package:Edukids/repository/user_repository.dart';
import 'package:Edukids/viewmodels/base_view_model.dart';
import 'package:flutter/material.dart';

import '../models/lesson/lesson_model.dart';
import '../services/shared_pref_service.dart';

class ProductViewModel extends BaseViewModel {
  final ProductRepository productRepository;
  ProductViewModel({required this.productRepository});

  List<LessonModel> listProduct = [];
  List<LessonModel> listProductOrder = [];
  @override
  void onInitView(BuildContext context) {
    getAllProduct();
    locator<UserRepository>().getProfile();
    super.onInitView(context);
  }

  Future getAllProduct() async {
    try {
      print('getAllProduct() is called'); // Thêm log để kiểm tra xem hàm có được gọi không
      listProduct = await productRepository.getAllProduct();
      print('List of Products: $listProduct'); // Kiểm tra dữ liệu sau khi lấy từ API
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e'); // Thêm log để kiểm tra lỗi
    }
  }

  Future<List<LessonModel?>> fetchCartProducts() async {
    listProductOrder = await SharedPrefService().getCartData();
    return listProductOrder;
  }

  Future<void> incrementQuantity(int productId) async {
    await SharedPrefService().incrementQuantity(productId);
    fetchCartProducts();
    notifyListeners();
  }

  Future<void> decrementQuantity(int productId) async {
    await SharedPrefService().decrementQuantity(productId);
    fetchCartProducts();
    notifyListeners();
  }

  Future<void> removeProductFromCart(int productId) async {
    await SharedPrefService().removeProductFromCart(productId);
    fetchCartProducts();
    notifyListeners();
  }

  Future<void> clearCart() async {
    await SharedPrefService().clearCart();
    fetchCartProducts();
    notifyListeners();
  }

  double get totalCartAmount {
    return listProductOrder.fold(
        0, (total, current) => total + current.price * current.quantity);
  }
}

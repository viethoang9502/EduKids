import '../data/remote/api_endpoint.dart';
import '../models/order/order_model.dart';
import '../services/network_api_service.dart';

abstract class OrderRepository {
  Future<OrderModel> postOrder({
    required String userId,
    required String fullname,
    required String email,
    required String phoneNumber,
    required String address,
    required String note,
    required double totalMoney,
    required String shippingMethod,
    required String paymentMethod,
    required List<CartItem> cartItems,
  });
}

class OrderRepositoryImpl extends OrderRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  @override
  Future<OrderModel> postOrder({
    required String userId,
    required String fullname,
    required String email,
    required String phoneNumber,
    required String address,
    required String note,
    required double totalMoney,
    required String shippingMethod,
    required String paymentMethod,
    required List<CartItem> cartItems,
  }) async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "fullname": fullname,
      "email": email,
      "phone_number": phoneNumber,
      "address": address,
      "note": note,
      "total_money": totalMoney,
      "shipping_method": shippingMethod,
      "payment_method": paymentMethod,
      "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
    };

    try {
      var response =
          await _apiServices.post(url: ApiEndPoint.order, data: data);
      if (response is Map<String, dynamic>) {
        return OrderModel.fromJson(response);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      rethrow;
    }
  }
}

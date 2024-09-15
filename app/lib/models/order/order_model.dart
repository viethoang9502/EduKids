class OrderModel {
  int userId;
  String fullname;
  String email;
  String phoneNumber;
  String address;
  String note;
  double totalMoney;
  String shippingMethod;
  String paymentMethod;
  List<CartItem> cartItems;

  OrderModel({
    required this.userId,
    required this.fullname,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.note,
    required this.totalMoney,
    required this.shippingMethod,
    required this.paymentMethod,
    required this.cartItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        userId: json["user_id"] ?? 0,
        fullname: json["fullname"] ?? '',
        email: json["email"] ?? '',
        phoneNumber: json["phone_number"] ?? '',
        address: json["address"] ?? '',
        note: json["note"] ?? '',
        totalMoney: (json["total_money"] ?? 0.0).toDouble(),
        shippingMethod: json["shipping_method"] ?? '',
        paymentMethod: json["payment_method"] ?? '',
        cartItems: (json["cart_items"] as List<dynamic>?)
                ?.map((x) => CartItem.fromJson(x))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
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
}

class CartItem {
  int productId;
  int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json["product_id"] ?? 0,
        quantity: json["quantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
      };
}

// services/product_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category/category_model.dart';
import '../models/lesson/lesson_model.dart';

class ProductService {
  static const String baseUrl = 'https://gdtth.ibme.edu.vn/api/v1'; // Thay URL của bạn vào đây

  static Future<List<Category>> getCategories(int page, int limit) async {
    final response = await http.get(Uri.parse('$baseUrl/categories?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      // Đảm bảo dữ liệu được giải mã dưới dạng UTF-8
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> data = jsonDecode(responseBody)['data'];
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<FetchedProducts> getProducts(int categoryId, int page, int limit, String keyword) async {
    final uri = Uri.parse('$baseUrl/lessons?category_id=$categoryId&page=$page&limit=$limit&keyword=$keyword');

    final response = await http.get(uri);
    print('Request URL: $uri'); // Log URL để kiểm tra tham số

    if (response.statusCode == 200) {
      try {
        // Đảm bảo dữ liệu được giải mã dưới dạng UTF-8
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody)['data'];
        List<LessonModel> products = (data['lessons'] as List)
            .map((json) => LessonModel.fromJson(json))
            .toList();
        int totalPages = data['totalPages'];
        return FetchedProducts(products: products, totalPages: totalPages);
      } catch (e) {
        throw Exception('Failed to parse JSON: $e');
      }
    } else {
      throw Exception('Failed to load products: ${response.reasonPhrase}');
    }
  }
}

class FetchedProducts {
  final List<LessonModel> products;
  final int totalPages;

  FetchedProducts({required this.products, required this.totalPages});
}

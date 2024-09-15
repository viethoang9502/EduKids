import '../data/remote/api_endpoint.dart';
import '../models/lesson/lesson_model.dart';
import '../services/network_api_service.dart';

abstract class ProductRepository {
  Future<List<LessonModel>> getAllProduct();
}

class ProductRepositoryImpl extends ProductRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  @override
  Future<List<LessonModel>> getAllProduct() async {
    try {
      dynamic response = await _apiServices.get(url: ApiEndPoint.products);
      print('API Response: $response'); // Log phản hồi từ API để kiểm tra cấu trúc

      // Truy xuất đúng đường dẫn đến 'lessons' trong phản hồi
      final lessons = response['data']?['lessons'];
      if (lessons == null || lessons is! List) {
        throw Exception('Lessons not found or not a List'); // Ném lỗi nếu không hợp lệ
      }

      // Chuyển đổi danh sách lessons thành LessonModel
      List<LessonModel> listProducts = (lessons as List)
          .map((json) => LessonModel.fromJson(json))
          .toList();
      return listProducts;
    } catch (e) {
      print('Error during parsing: $e'); // Log lỗi cụ thể
      rethrow;
    }
  }
}

class LessonModel {
  int id;
  String name;
  double price;
  String description;
  String thumbnail;
  int quantity;
  List<String> lessonImages; // Danh sách URL của ảnh
  List<String> lessonVideos; // Danh sách URL của video

  LessonModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.quantity,
    required this.lessonImages,
    required this.lessonVideos,
  });

  // Phương thức để tạo một đối tượng từ JSON
  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    price: json["price"]?.toDouble() ?? 0.0,
    description: json["description"] ?? '',
    thumbnail: json["thumbnail"] ?? '',
    quantity: json['quantity'] ?? 0,
    lessonImages: List<String>.from(
        json['lesson_images']?.map((x) => x['image_url']) ?? []),
    lessonVideos: List<String>.from(
        json['lesson_videos']?.map((x) => x['video_url']) ?? []),
  );

  // Phương thức từ JSON để dùng cho Order
  factory LessonModel.fromJsonOrder(Map<String, dynamic> json) => LessonModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    price: json["price"]?.toDouble() ?? 0.0,
    description: json["description"] ?? '',
    thumbnail: json["thumbnail"] ?? '',
    quantity: json['quantity'] ?? 0,
    lessonImages: List<String>.from(
        json['lesson_images']?.map((x) => x['image_url']) ?? []),
    lessonVideos: List<String>.from(
        json['lesson_videos']?.map((x) => x['video_url']) ?? []),
  );

  String get thumbnailUrl => "https://gdtth.ibme.edu.vn/api/v1/lessons/images/$thumbnail";

  // Phương thức để chuyển đối tượng thành JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
    "thumbnail": thumbnail,
    "quantity": quantity,
    "lesson_images": lessonImages.map((x) => {'image_url': x}).toList(),
    "lesson_videos": lessonVideos.map((x) => {'video_url': x}).toList(),
  };
}

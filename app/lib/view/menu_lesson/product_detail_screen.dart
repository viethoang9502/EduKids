import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import thư viện Google Fonts
import 'package:Edukids/services/shared_pref_service.dart';
import '../../models/lesson/lesson_model.dart';
import '../../res/style/app_colors.dart';
import '../../video_player/video_player.dart';
import '../order/order_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final LessonModel product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  int currentImageIndex = 0;
  int currentVideoIndex = 0;
  bool isViewingImages = true; // Biến để chuyển giữa xem ảnh và video

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.product.name,
          style: GoogleFonts.fredokaOne(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            Center(
              child: Text(
                '${widget.product.description}',
                style: GoogleFonts.balooBhaijaan2(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => FullScreenMedia(
                    imageUrl:
                    'https://gdtth.ibme.edu.vn/api/v1/lessons/images/${widget.product.lessonImages[currentImageIndex]}',
                    videoUrl: widget.product.lessonVideos.isNotEmpty
                        ? 'https://gdtth.ibme.edu.vn/api/v1/lessons/videos/${widget.product.lessonVideos[currentVideoIndex]}'
                        : '', // Nếu không có video, truyền một chuỗi rỗng
                    isImage: isViewingImages,
                  ),
                ));
              },
              child: Container(
                width: double.infinity,
                child: isViewingImages
                    ? Image.network(
                  'https://gdtth.ibme.edu.vn/api/v1/lessons/images/${widget.product.lessonImages[currentImageIndex]}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/default.png',
                          fit: BoxFit.cover),
                )
                    : widget.product.lessonVideos.isNotEmpty
                    ? AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayerWidget(
                    key: ValueKey<String>(
                        widget.product.lessonVideos[currentVideoIndex]),
                    url:
                    'https://gdtth.ibme.edu.vn/api/v1/lessons/videos/${widget.product.lessonVideos[currentVideoIndex]}',
                  ),
                )
                    : Center(
                  child: Text(
                    'Hiện chưa có video',
                    style: GoogleFonts.balooBhaijaan2(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isViewingImages = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent, // Màu nền
                      onPrimary: Colors.white, // Màu chữ
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Xem Ảnh', style: GoogleFonts.balooBhaijaan2(fontSize: 18)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isViewingImages = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent, // Màu nền
                      onPrimary: Colors.white, // Màu chữ
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Xem Video', style: GoogleFonts.balooBhaijaan2(fontSize: 18)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isViewingImages) {
                          currentImageIndex = (currentImageIndex - 1 +
                              widget.product.lessonImages.length) %
                              widget.product.lessonImages.length;
                        } else {
                          currentVideoIndex = (currentVideoIndex - 1 +
                              widget.product.lessonVideos.length) %
                              widget.product.lessonVideos.length;
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.deepPurpleAccent),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isViewingImages) {
                          currentImageIndex = (currentImageIndex + 1) %
                              widget.product.lessonImages.length;
                        } else {
                          currentVideoIndex = (currentVideoIndex + 1) %
                              widget.product.lessonVideos.length;
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_forward, color: Colors.deepPurpleAccent),
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  SharedPrefService().updateCartWithProductId(
                    widget.product.id,
                    widget.product.name,
                    widget.product.price,
                    widget.product.description,
                    widget.product.thumbnail,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderScreen()),
                  );                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent, // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Theo dõi', style: GoogleFonts.balooBhaijaan2(fontSize: 20)),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenMedia extends StatelessWidget {
  final String imageUrl;
  final String videoUrl;
  final bool isImage;

  const FullScreenMedia(
      {Key? key,
        required this.imageUrl,
        required this.videoUrl,
        required this.isImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isImage
            ? Image.network(imageUrl)
            : videoUrl.isNotEmpty
            ? VideoPlayerWidget(url: videoUrl)
            : Text(
          'Hiện chưa có video',
          style: GoogleFonts.balooBhaijaan2(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
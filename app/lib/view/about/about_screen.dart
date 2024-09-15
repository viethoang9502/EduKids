import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/banner2.png',
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    width: double.infinity,
                    height: 350,
                  ),
                  Column(
                    children: [
                      Text(
                        'Hệ thống Học tập và Tương tác cho Trẻ Tiền Tiểu học',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(128, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                        child: Text(
                          'Giải pháp giáo dục tiên tiến cho trẻ từ 3 đến 6 tuổi, mang lại trải nghiệm học tập thú vị và bổ ích.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(128, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Khám phá ngay'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF71c8ce),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // About Content Section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Giới Thiệu về Phần Mềm',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF71c8ce),
                      ),
                    ),
                    Container(
                      height: 4,
                      width: 100,
                      color: Color(0xFF71c8ce),
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Text(
                      'Phần mềm được phát triển bởi iBME lab 2024, nhằm mang đến môi trường học tập hiện đại và tương tác cho trẻ tiền tiểu học. Tích hợp các bài học chữ cái, tiếng Việt, toán học và các phép tính cơ bản, phần mềm cung cấp cho trẻ nền tảng học tập vững chắc và sự chuẩn bị tốt nhất cho tương lai.',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Tìm hiểu thêm'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF71c8ce),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset('assets/images/logo.png', width: 240, height: 240),
                  ],
                ),
              ),

              // Features Section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Các Chức Năng Nổi Bật',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF71c8ce),
                      ),
                    ),
                    Container(
                      height: 4,
                      width: 100,
                      color: Color(0xFF71c8ce),
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    GridView.count(
                      crossAxisCount: 1,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.32 / 0.8,
                      children: [
                        FeatureCard(
                          icon: Icons.spellcheck,
                          title: 'Học Chữ Cái & Tiếng Việt',
                          description: 'Giúp trẻ làm quen với chữ cái và từ vựng qua các trò chơi tương tác và video minh họa.',
                        ),
                        FeatureCard(
                          icon: Icons.calculate,
                          title: 'Toán Học Cơ Bản',
                          description: 'Cung cấp các bài học về số học, phép cộng và phép trừ đơn giản qua hình ảnh và bài tập thực tế.',
                        ),
                        FeatureCard(
                          icon: Icons.play_circle_fill,
                          title: 'Video và Hình Ảnh Minh Họa',
                          description: 'Chất lượng cao, nội dung phong phú, phù hợp với chương trình giáo dục của sách giáo khoa Cánh Diều.',
                        ),
                        FeatureCard(
                          icon: Icons.games,
                          title: 'Trò Chơi Tương Tác',
                          description: 'Kích thích sự tò mò và khả năng học hỏi qua các trò chơi vui nhộn và đầy thử thách.',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Footer Section
              Container(
                color: Color(0xFF71c8ce),
                padding: EdgeInsets.all(20),
                child: Text(
                  '© Phát triển bởi iBME lab 2024. Tất cả các quyền được bảo lưu.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Color(0xFF71c8ce).withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 48, color: Color(0xFF71c8ce)),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(description, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

import 'package:Edukids/res/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/category/category_model.dart';
import '../../models/lesson/lesson_model.dart';
import '../../services/product_service.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<LessonModel> products = [];
  List<Category> categories = [];
  int? selectedCategoryId;
  int currentPage = 0;
  int totalPages = 0;
  int itemsPerPage = 12;
  String keyword = "";
  ScrollController _scrollController = ScrollController(); // Tạo ScrollController

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchProducts();
  }

  void fetchCategories() async {
    try {
      final fetchedCategories = await ProductService.getCategories(0, 100);
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  void fetchProducts() async {
    try {
      final fetchedProducts = await ProductService.getProducts(
        selectedCategoryId ?? 0,
        currentPage,
        itemsPerPage,
        keyword,
      );
      setState(() {
        products = fetchedProducts.products;
        totalPages = fetchedProducts.totalPages;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void onCategorySelected(int? categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
      currentPage = 0;
    });
    fetchProducts();
  }

  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
    fetchProducts();
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void onKeywordChanged(String value) {
    setState(() {
      keyword = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Danh sách bài',
          style: GoogleFonts.fredokaOne(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tìm kiếm bài học',
                labelStyle: TextStyle(color: AppColors.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: onKeywordChanged,
              onSubmitted: (_) => fetchProducts(),
            ),
          ),
          DropdownButton<int>(
            value: selectedCategoryId,
            items: categories.map((Category category) {
              return DropdownMenuItem<int>(
                value: category.id,
                child: Text(
                  category.name,
                  style: GoogleFonts.balooBhaijaan2(),
                ),
              );
            }).toList(),
            onChanged: onCategorySelected,
            hint: Text(
              'Chọn danh mục',
              style: GoogleFonts.balooBhaijaan2(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController, // Sử dụng ScrollController
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25 / 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Image.network(
                              product.thumbnailUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/images/default.png', fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            product.name,
                            style: GoogleFonts.balooBhaijaan2(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '${product.description}',
                          style: GoogleFonts.balooBhaijaan2(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalPages, (index) {
                return IconButton(
                  onPressed: () => onPageChanged(index),
                  icon: Icon(
                    Icons.circle,
                    color: index == currentPage ? Colors.blue : Colors.grey,
                  ),
                );
              }).map((iconButton) {
                return Flexible(child: iconButton);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

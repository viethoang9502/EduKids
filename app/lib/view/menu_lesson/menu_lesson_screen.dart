import 'package:Edukids/repository/lesson_repository.dart';
import 'package:Edukids/res/style/app_colors.dart';
import 'package:Edukids/view/menu_lesson/product_detail_screen.dart';
import 'package:Edukids/viewmodels/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../locator.dart';
import '../../models/lesson/lesson_model.dart';
import '../../services/shared_pref_service.dart';
import '../../utils/validators.dart';
import '../widget/ui_appbar.dart';
import '../widget/ui_product.dart';

class MenuFoodScreen extends StatefulWidget {
  const MenuFoodScreen({Key? key}) : super(key: key);

  @override
  _MenuFoodScreenState createState() => _MenuFoodScreenState();
}

class _MenuFoodScreenState extends State<MenuFoodScreen> {
  late ProductViewModel viewModel;

  @override
  void initState() {
    viewModel =
        ProductViewModel(productRepository: locator<ProductRepository>())
          ..onInitView(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: UiAppBar(title: "DANH SÁCH"),
        body: Selector<ProductViewModel, List<LessonModel>>(
            selector: (_, viewModel) => viewModel.listProduct,
            builder: (_, viewState, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.listProduct.length,
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final product = viewModel.listProduct[index];
                return GestureDetector(
                  onTap: () {
                    // Điều hướng đến trang chi tiết sản phẩm
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: UiProduct(
                    productId: product.id.toString(),
                    image: product.thumbnail.toString(),
                    description: product.description.toString(),
                    title: product.name.toString(),
                    price: NumberFormat.currency(locale: 'vi', symbol: 'VND', decimalDigits: 0)
                        .format(product.price),
                    onTap: () {
                      SharedPrefService().updateCartWithProductId(
                        product.id,
                        product.name,
                        product.price,
                        product.description,
                        product.thumbnail,
                      );
                    },
                  ),
                );
              },
                )),
      ),
    );
  }
}


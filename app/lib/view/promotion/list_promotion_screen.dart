import 'package:Edukids/models/lesson/lesson_model.dart';
import 'package:Edukids/repository/lesson_repository.dart';
import 'package:Edukids/res/style/app_colors.dart';
import 'package:Edukids/services/shared_pref_service.dart';
import 'package:Edukids/viewmodels/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../widget/ui_appbar.dart';
import '../widget/ui_product.dart';

class ListPromotionScreen extends StatefulWidget {
  const ListPromotionScreen({Key? key}) : super(key: key);

  @override
  _ListPromotionScreenState createState() => _ListPromotionScreenState();
}

class _ListPromotionScreenState extends State<ListPromotionScreen> {
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
        appBar: UiAppBar(title: "KHUYẾN MÃI"),
        body: Selector<ProductViewModel, List<LessonModel>>(
            selector: (_, viewModel) => viewModel.listProduct,
            builder: (_, viewState, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.listProduct.length,
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return UiProduct(
                      productId: viewModel.listProduct[index].id.toString(),
                      image: viewModel.listProduct[index].thumbnail.toString(),
                      title: viewModel.listProduct[index].name.toString(),
                      price: viewModel.listProduct[index].price.toString(),
                      description: viewModel.listProduct[index].name.toString(),
                      onTap: () => SharedPrefService().updateCartWithProductId(
                          viewModel.listProduct[index].id,
                          viewModel.listProduct[index].name.toString(),
                          viewModel.listProduct[index].price,
                          viewModel.listProduct[index].description.toString(),
                          viewModel.listProduct[index].thumbnail.toString()),
                    );
                  },
                )),
      ),
    );
  }
}

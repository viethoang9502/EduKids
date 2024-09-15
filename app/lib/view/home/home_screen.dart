import 'package:Edukids/repository/user_repository.dart';
import 'package:Edukids/view/shop/shop.dart';
import 'package:Edukids/viewmodels/user_view_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../repository/lesson_repository.dart';
import '../../res/constant/app_assets.dart';
import '../../res/constant/app_fonts.dart';
import '../../res/style/app_colors.dart';
import '../../services/shared_pref_service.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/validators.dart';
import '../../viewmodels/product_view_model.dart';
import '../about/about_screen.dart';
import '../menu_lesson/menu_lesson_screen.dart';
import '../menu_lesson/product_detail_screen.dart';
import '../menu_lesson/product_list_screen.dart';
import '../order/order_screen.dart';
import '../profile/profile_screen.dart';
import '../promotion/list_promotion_screen.dart';
import '../recent_order/recent_order_screen.dart';
import '../widget/ui_adv.dart';
import '../widget/ui_card_home.dart';
import '../widget/ui_card_redeem.dart';
import '../widget/ui_product.dart';
import '../widget/ui_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List imageList = [
  {"id": 1, "image_path": AppAssets.banner1},
  {"id": 2, "image_path": AppAssets.banner2},
  {"id": 3, "image_path": AppAssets.banner3}
];
final CarouselController carouselController = CarouselController();
int currentIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  late ProductViewModel viewModel;
  late UserViewModel userViewModel;

  @override
  void initState() {
    viewModel =
        ProductViewModel(productRepository: locator<ProductRepository>())
          ..onInitView(context);
    userViewModel = UserViewModel(userRepository: locator<UserRepository>())
      ..onInitView(context);
    userViewModel.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellowColor,
      appBar: AppBar(
        backgroundColor: AppColors.yellowColor,
        leadingWidth: 78,
        toolbarHeight: 75,
        elevation: 0,
        leading: Row(
          children: [
            SizedBox(
              width: DimensManager.dimens.setWidth(16),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Image.asset(
                  AppAssets.Edukids,
                  width: DimensManager.dimens.setWidth(50),
                  height: DimensManager.dimens.setWidth(50),
                ),
              ),
            ),
          ],
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderScreen()),
                );
              },
              icon: const Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
              )),
        ],
        title: ChangeNotifierProvider.value(
          value: userViewModel,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
                child: Consumer<UserViewModel>(
                  builder: (_, user, __) => UIText(
                    user.userModel?.fullname ?? "HOÀNG QUANG HUY",
                    style: TextStyle(
                        fontSize: DimensManager.dimens.setSp(20),
                        color: Colors.white,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _slideBanner(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _mainFuncUI(),
                ],
              ),
            ),
            _foodSlideUI(),
            _redeemSlideUI(),
            _advUI(),
          ],
        ),
      ),
    );
  }

  _advUI() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: DimensManager.dimens.setHeight(32)),
            UIText(
              'Tin mới nhất',
              style: TextStyle(
                  fontSize: DimensManager.dimens.setSp(16),
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: DimensManager.dimens.setHeight(12)),
            LayoutBuilder(builder: (context, constraints) {
              final itemWidth =
                  (constraints.maxWidth - DimensManager.dimens.setWidth(16)) /
                      2;
              return Wrap(
                spacing: DimensManager.dimens.setWidth(16),
                runSpacing: DimensManager.dimens.setHeight(16),
                children: [
                  InkWell(
                    onTap: () {
                      // Handle tap
                    },
                    child: const UiItemAdv(
                      image: AppAssets.banner3,
                      text: 'iBME LAB 2024',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Handle tap
                    },
                    child: const UiItemAdv(
                      image: AppAssets.banner1,
                      text: 'iBME LAB 2024',
                    ),
                  ),
                ]
                    .map((item) => SizedBox(
                          width: itemWidth,
                          child: item,
                        ))
                    .toList(),
              );
            }),
            SizedBox(height: DimensManager.dimens.setHeight(32)),
          ],
        ),
      ),
    );
  }

  _foodSlideUI() {
    return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<ProductViewModel>(
          builder: (context, value, child) => Container(
            color: AppColors.yellowColor,
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.9,
                enableInfiniteScroll: true,
                initialPage: 0,
                autoPlay: true,
                padEnds: true,
                pageSnapping: true,
                height: 200,
              ),
              items: viewModel.listProduct.map((product) {
                return Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: UiProduct(
                    productId: product.id.toString(),
                    image: product.thumbnail,
                    description: product.description,
                    title: product.name,
                    price: Validators.formatCurrency(product.price),
                    onTap: () {
                      // Cập nhật giỏ hàng trước
                      SharedPrefService().updateCartWithProductId(
                        product.id,
                        product.name.toString(),
                        product.price,
                        product.description,
                        product.thumbnail.toString(),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }

  _redeemSlideUI() {
    return Container(
      color: Colors.white,
      child: CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 0.46,
              enableInfiniteScroll: false,
              initialPage: 1,
              autoPlay: true,
              padEnds: false,
              pageSnapping: true,
              height: 180,
              aspectRatio: 1),
          items: [
            UIRedeemFood(
              onTap: () {},
              color: AppColors.yellowColor,
              icon: AppAssets.icShop,
              text: 'CHƠI GAME',
            ),
            UIRedeemFood(
              onTap: () {},
              color: const Color.fromARGB(255, 151, 98, 18),
              icon: AppAssets.icBirthDay,
              text: 'TIỆC SINH NHẬT',
            ),
            UIRedeemFood(
              onTap: () {},
              color: const Color.fromARGB(255, 18, 176, 100),
              icon: AppAssets.icSales,
              text: 'THÔNG BÁO',
            ),
          ]),
    );
  }

  _mainFuncUI() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 10,
        children: [
          UICardHome(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AboutScreen()),
            ),
            color: AppColors.primaryColor,
            icon: AppAssets.icSales,
            text: 'THÔNG BÁO',
          ),
          UICardHome(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductListScreen()),
            ),
            color: AppColors.primaryColor,
            icon: AppAssets.icLunch,
            text: 'BÀI HỌC',
          ),
          UICardHome(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OrderScreen()),
            ),
            color: AppColors.primaryColor,
            icon: AppAssets.icShopping,
            text: 'ĐANG HỌC',
          ),
          UICardHome(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            ),
            color: AppColors.primaryColor,
            icon: AppAssets.icShop,
            text: 'TRÒ CHƠI',
          ),
        ],
      )
    ]);
  }

  _slideBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.zero, // Adjust as needed
      child: Container(
        margin: EdgeInsets.zero, // No extra space around the container
        padding: EdgeInsets.zero, // No internal padding
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: CarouselSlider(
          items: imageList
              .map(
                (item) => Image.asset(
                  item['image_path'],
                  fit: BoxFit.cover,
                  width: DimensManager
                      .dimens.fullWidth, // Ensures it takes the full width
                ),
              )
              .toList(),
          carouselController: carouselController,
          options: CarouselOptions(
            height: DimensManager.dimens.setHeight(400),
            viewportFraction: 1.0, // Ensures no padding inside the carousel
            scrollPhysics: const BouncingScrollPhysics(),
            autoPlay: true,
          ),
        ),
      ),
    );
  }
}

import 'package:Edukids/res/style/app_colors.dart';
import 'package:Edukids/view/widget/ui_text.dart';
import 'package:flutter/material.dart';

import '../widget/ui_location_card.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: const UIText(
            "ATM BIDV",
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_rounded,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                UiLocationCard(
                  title: "ATM 01 Tôn Thất Tùng",
                  address:
                      "Số 1, phố Tôn Thất Tùng, \n Phường Trung Tự, Đống Đa",
                  phone: "(024) 6329-9797",
                  time: "0:00 AM - 12:00 PM (Thứ 2 - Chủ Nhật)",
                ),
                UiLocationCard(
                  title: "ATM 165 Thái Hà",
                  address: "Số 165, phố Thái Hà,  \n  Phường Láng Hạ, Đống Đa",
                  phone: "(024) 6329-9347",
                  time: "0:00 AM - 12:00 PM (Thứ 2 - Chủ Nhật)",
                ),
              ],
            ),
          ),
        ));
  }
}

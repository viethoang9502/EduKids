import 'package:Edukids/res/style/app_colors.dart';
import 'package:Edukids/view/order/order_screen.dart';
import 'package:Edukids/view/widget/ui_text.dart';
import 'package:flutter/material.dart';

class UiAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  UiAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      title: UIText(
        title,
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderScreen()),
              );
            },
            icon: const Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
            )),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

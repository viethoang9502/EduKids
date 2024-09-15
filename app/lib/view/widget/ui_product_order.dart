import 'package:Edukids/view/widget/ui_text.dart';
import 'package:flutter/material.dart';
import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';

class UiProductOrder extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String description;
  final int quantity;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const UiProductOrder({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.quantity,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12.0,
          )
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Image.network("https://gdtth.ibme.edu.vn/api/v1/lessons/images/$image",
              width: 100,
              height: 100,
              fit: BoxFit.cover, errorBuilder: (BuildContext context,
                  Object exception, StackTrace? stackTrace) {
            return Image.asset(
              AppAssets.combo1,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            );
          }),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIText(
                  title,
                  maxLines: 2,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  size: 14.0,
                ),
                UIText(
                  description,
                  fontWeight: FontWeight.bold,
                  size: 14.0,
                ),
                // Row(
                //   children: [
                //     IconButton(
                //       icon: const Icon(Icons.remove),
                //       onPressed: onDecrement,
                //     ),
                //     UIText(
                //       '$quantity',
                //       size: 16.0,
                //       fontWeight: FontWeight.bold,
                //     ),
                //     IconButton(
                //       icon: const Icon(Icons.add),
                //       onPressed: onIncrement,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

import 'package:Edukids/view/widget/ui_text.dart';
import 'package:flutter/material.dart';

import '../../utils/dimens/dimens_manager.dart';

class UiItemAdv extends StatelessWidget {
  const UiItemAdv({super.key, required this.image, required this.text});
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DimensManager.dimens.setHeight(228),
      width: DimensManager.dimens.setWidth(171),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            height: DimensManager.dimens.setHeight(170),
            width: DimensManager.dimens.setWidth(171),
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: DimensManager.dimens.setHeight(12),
              horizontal: DimensManager.dimens.setWidth(8),
            ),
            child: UIText(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: DimensManager.dimens.setSp(13),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

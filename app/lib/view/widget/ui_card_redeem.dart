import 'package:Edukids/view/widget/ui_text.dart';
import 'package:flutter/material.dart';

import '../../res/constant/app_fonts.dart';
import '../../utils/dimens/dimens_manager.dart';

class UIRedeemFood extends StatelessWidget {
  const UIRedeemFood({
    super.key,
    required this.onTap,
    required this.color,
    required this.icon,
    required this.text,
  });
  final VoidCallback onTap;
  final Color color;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: DimensManager.dimens.setWidth(170),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(3, 7),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(icon,
                height: DimensManager.dimens.setHeight(45),
                width: DimensManager.dimens.setWidth(45)),
            const SizedBox(
              height: 20,
            ),
            UIText(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: DimensManager.dimens.setSp(13.5),
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );
  }
}

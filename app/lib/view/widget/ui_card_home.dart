import 'package:Edukids/view/widget/ui_text.dart';
import 'package:flutter/material.dart';

import '../../res/constant/app_fonts.dart';
import '../../utils/dimens/dimens_manager.dart';

class UICardHome extends StatelessWidget {
  const UICardHome({
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
          child: Column(children: [
            Image.asset(icon,
                height: DimensManager.dimens.setHeight(45),
                width: DimensManager.dimens.setWidth(45)),
            const SizedBox(
              height: 5,
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

class ItemScholarshipUI extends StatelessWidget {
  const ItemScholarshipUI({
    required this.onTap,
    required this.icon,
    required this.text,
    super.key,
  });
  final VoidCallback onTap;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Image.asset(
              icon,
              height: DimensManager.dimens.setHeight(45),
              width: DimensManager.dimens.setWidth(45),
            ),
            SizedBox(width: DimensManager.dimens.setWidth(11)),
            UIText(
              text,
              style: TextStyle(
                  fontSize: DimensManager.dimens.setSp(15),
                  color: Colors.black,
                  fontFamily: AppFonts.nunito,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

class ActiveCard extends StatelessWidget {
  const ActiveCard({super.key, required this.image, required this.text});
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
            color: Colors.black.withOpacity(0.06),
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
            padding: const EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
            child: UIText(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: DimensManager.dimens.setSp(13),
                color: Colors.black,
                fontFamily: AppFonts.nunito,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

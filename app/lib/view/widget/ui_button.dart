import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';

class UIButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final void Function()? onTap;
  const UIButton(
      {super.key, required this.child, this.color = AppColors.primaryColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: DimensManager.dimens.setWidth(342),
          height: DimensManager.dimens.setHeight(48),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

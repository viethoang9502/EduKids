import 'package:Edukids/view/widget/ui_text.dart';
import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';

class UIOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final String title;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Widget? icon;

  const UIOutlineButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.padding = EdgeInsets.zero,
    this.titleStyle,
    this.backgroundColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.white,
          minimumSize: Size(double.infinity, DimensManager.dimens.setHeight(48)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
          ),
          side: const BorderSide(color: AppColors.primaryColor),
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? const SizedBox.shrink(),
              SizedBox(
                width: DimensManager.dimens.setWidth(10),
              ),
              UIText(
                title,
                style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: DimensManager.dimens.setSp(16),
                        fontWeight: FontWeight.w600)
                    .merge(titleStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

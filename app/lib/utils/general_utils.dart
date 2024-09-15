import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../res/style/app_colors.dart';
import '../view/widget/ui_text.dart';
import 'dimens/dimens_manager.dart';

class Utils {
  static showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.75),
    );
  }

  static snackBar({
    required String message,
    required BuildContext context,
    Color? backgroundColor = Colors.red,
  }) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: backgroundColor, content: Text(message)));
  }

  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showPopup(
    BuildContext context, {
    required String icon,
    required String title,
    String? message,
    Widget? action,
    String? messageBetween,
    String? messageEnd,
    String? messageEndBold,
    VoidCallback? onTap,
    bool outsideClose = true,
  }) {
    showDialog(
      barrierDismissible: outsideClose,
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: onTap,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(DimensManager.dimens.setWidth(24)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: DimensManager.dimens.setWidth(16),
                  vertical: DimensManager.dimens.setHeight(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: DimensManager.dimens.setWidth(48),
                    height: DimensManager.dimens.setWidth(48),
                  ),
                  SizedBox(
                    height: DimensManager.dimens.setHeight(15),
                  ),
                  UIText(
                    title,
                    size: DimensManager.dimens.setSp(20),
                    color: AppColors.requiredColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const Divider(
                    color: AppColors.gray,
                    height: 36,
                  ),
                  Column(
                    children: [
                     
                      if (message != null && action != null)
                        SizedBox(
                          height: DimensManager.dimens.setHeight(24),
                        ),
                      if (action != null) ...[action],
                      SizedBox(
                        height: DimensManager.dimens.setHeight(8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showProgressingDialog(
    BuildContext context, {
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(DimensManager.dimens.setRadius(15)),
                  child: UIText(
                    message,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: DimensManager.dimens.setSp(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideProgressDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

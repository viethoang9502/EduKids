import 'package:flutter/material.dart';

import '../../res/constant/app_fonts.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';

typedef OnChanged = Function(String?);

class UIDropdownInput extends StatelessWidget {
  final String? title;
  final String? hint;
  final List<String> list;
  final OnChanged? onChanged;

  const UIDropdownInput({
    super.key,
    this.title,
    this.hint,
    required this.list,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(DimensManager.dimens.setHeight(15)),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: DimensManager.dimens.setSp(14),
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w400,
              color: AppColors.hintTextColor,
              height: 1.25,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          items: list.map((String val) {
            return DropdownMenuItem(
              value: val,
              child: Text(
                val,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

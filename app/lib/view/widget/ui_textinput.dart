import 'package:flutter/material.dart';

import '../../res/constant/app_fonts.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';

typedef OnChanged = Function(String);
typedef OnSubmit = Function(String);

class UITextInput extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? errorMessage;
  final bool isRequired;
  final bool isObscure;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final VoidCallback? onSuffixIconPressed;
  final VoidCallback? onFocus;
  final OnChanged? onChanged;
  final OnSubmit? onSubmitted;

  const UITextInput(
      {super.key,
      this.hint,
      this.errorMessage,
      this.isRequired = false,
      this.isObscure = false,
      this.maxLength,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.onSuffixIconPressed,
      this.onFocus,
      this.onChanged,
      this.onSubmitted,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: DimensManager.dimens.setHeight(58),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: TextField(
              onTap: onFocus,
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              maxLength: maxLength,
              style: TextStyle(
                fontSize: DimensManager.dimens.setSp(14),
                height: 1.5,
              ),
              textAlignVertical: TextAlignVertical.center,
              obscureText: isObscure,
              autocorrect: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(DimensManager.dimens.setRadius(20)),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: DimensManager.dimens.setSp(16),
                  fontFamily: AppFonts.nunito,
                  fontWeight: FontWeight.w400,
                  color: AppColors.hintTextColor,
                  height: 1,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                suffixIcon: keyboardType == TextInputType.visiblePassword
                    ? IconButton(
                        icon: Icon(!isObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: onSuffixIconPressed)
                    : null,
              ),
              keyboardType: keyboardType,
            ),
          ),
        ),
        if (!(errorMessage == null || errorMessage!.isEmpty))
          Padding(
            padding: EdgeInsets.only(top: DimensManager.dimens.setHeight(4)),
            child: Text(
              errorMessage!,
              style: TextStyle(
                color: Colors.white,
                fontSize: DimensManager.dimens.setSp(13),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}

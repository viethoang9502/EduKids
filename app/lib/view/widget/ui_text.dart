import 'package:flutter/material.dart';

import '../../res/constant/app_fonts.dart';

class UIText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final bool? softWrap;
  final Color color;
  final double size;
  final TextDecoration decoration;
  final FontWeight fontWeight;
  final String? fontFamily;

  const UIText(this.text,
      {Key? key,
      this.style,
      this.strutStyle,
      this.maxLines,
      this.textAlign,
      this.overflow,
      this.softWrap,
      this.color = const Color(0xFF343A40),
      this.size = 16,
      this.decoration = TextDecoration.none,
      this.fontWeight = FontWeight.w600,
      this.fontFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.0,
      maxLines: maxLines,
      style: TextStyle(
              color: color,
              fontSize: size,
              letterSpacing: 0.75,
              fontFamily: fontFamily ?? AppFonts.nunito,
              fontWeight: fontWeight,
              height: 1.25,
              decoration: decoration)
          .merge(style),
      strutStyle: strutStyle,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
    );
  }
}

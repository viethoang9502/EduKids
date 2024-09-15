import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../res/constant/app_dimens.dart';

abstract class BaseDimens<T> {
  Orientation orientation = Orientation.portrait;

  double statusBarHeight = 0.0;
  double indicatorBarHeight = 0.0;

  double fullWidth = 0.0;
  double fullHeight = 0.0;

  double fullWidthSafeArea = 0.0;
  double fullHeightSafeArea = 0.0;

  double headerHeightWithStatusBar = 0.0;
  double headerHeight = 0.0;

  double paddingHorizontal = 0.0;

  //Width & Height with SafeArea
  void calculatorRatio<T>() {
    final devicePixelRatio = window.devicePixelRatio;

    fullWidth = window.physicalSize.width / devicePixelRatio;
    fullHeight = window.physicalSize.height / devicePixelRatio;
    indicatorBarHeight = window.viewPadding.bottom / devicePixelRatio;
    print("homeIndicatorHeight: $indicatorBarHeight");
    print("fullWidth: $fullWidth");
    print("fullHeight: $fullHeight");

    if (orientation == Orientation.portrait) {
      statusBarHeight = window.viewPadding.top / devicePixelRatio;
      paddingHorizontal = fullWidth * 0.07;
    } else {
      statusBarHeight = window.viewPadding.top / devicePixelRatio;
      paddingHorizontal = max(window.viewPadding.left, window.viewPadding.right);
    }

    fullWidthSafeArea = fullWidth;
    fullHeightSafeArea = fullHeight - (statusBarHeight + indicatorBarHeight);

    headerHeight = kToolbarHeight;
    headerHeightWithStatusBar = headerHeight + statusBarHeight;

    initialDimens<T>();
  }

  //Size determination for each screen
  void initialDimens<T>();

  void allowCalculatorSize({
    required BuildContext context,
    required VoidCallback calculateSizeCallback,
  }) {
    final media = MediaQuery.of(context);
    final newWidth = media.size.width;
    final newHeight = media.size.height;
    final newOrientation = media.orientation;
    final result =
        (newWidth != fullWidth) || (newHeight != fullHeight) || (newOrientation != orientation);

    if (result) {
      calculateSizeCallback.call();
    }
  }

  double setHeight(double height) {
    return fullHeight / AppDimens.designHeight * height;
  }

  double setWidth(double width) {
    return fullWidth / AppDimens.designWidth * width;
  }

  double get scaleHeight => fullHeight / AppDimens.designHeight;
  double get scaleWidth => fullWidth / AppDimens.designWidth;

  double setSp(double sp) {
    return min(scaleHeight, scaleWidth) * sp;
  }

  double setRadius(double radius) {
    return radius * min(scaleHeight, scaleWidth);
  }
}

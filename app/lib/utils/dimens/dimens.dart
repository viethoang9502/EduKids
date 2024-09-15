import 'dart:math';

import 'base_dimens.dart';

class Dimens extends BaseDimens {
  double paddingBottom = 0.0;

  @override
  void initialDimens<T>() {
    paddingBottom = max(indicatorBarHeight, 16);
  }
}

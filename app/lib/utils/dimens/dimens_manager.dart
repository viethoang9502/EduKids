import 'dimens.dart';

class DimensManager {
  static double fullWidthScreen = 0;

  static double fullHeightScreen = 0;

  DimensManager._() {
    _setDimens();
  }

  static DimensManager? _instance;

  static DimensManager get instance => _instance!;

  factory DimensManager() {
    _instance ??= DimensManager._();
    return _instance!;
  }

  void _setDimens() {
    _dimens = Dimens()..calculatorRatio();
  }

  /// common dimens
  static late Dimens _dimens;

  static Dimens get dimens => _dimens;
}

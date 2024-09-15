import 'package:flutter/material.dart';

import '../res/enum/view_state.dart';

abstract class BaseViewModel with ChangeNotifier {
  static final List<ChangeNotifier> _notifierList = [];

  bool _isEmptyNotifier = false;

  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  late BuildContext _context;

  BuildContext get context => _context;

  void onInitView(BuildContext context) {
    _context = context;
  }

  void setStateAndNotifier(ViewState viewState) {
    if (_isEmptyNotifier || (_viewState == viewState && viewState != ViewState.success)) return;
    _viewState = viewState;

    /// handle update [this] instance
    notifyListeners();

    /// notify to other view_model to update
    for (var notifier in _notifierList) {
      if (notifier != this) {
        notifier.notifyListeners();
      }
    }
  }

  void setState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  void updateUI() {
    notifyListeners();
  }

  ///
  void onBuildCompleted() {
    if (!_notifierList.contains(this)) {
      _notifierList.add(this);
    }
  }

  void removeChangeNotifier() {
    if (_notifierList.contains(this)) {
      _notifierList.remove(this);
    }
  }

  @override
  void dispose() {
    _isEmptyNotifier = true;
    removeChangeNotifier();
    super.dispose();
  }
}

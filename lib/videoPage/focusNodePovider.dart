import 'package:flutter/material.dart';

class FocusNodeProvider extends ChangeNotifier {
  FocusNode? _commentFocusNode;

  FocusNode get commentFocusNode => _commentFocusNode ??= FocusNode();

  void requestFocus() {
    if (_commentFocusNode != null) {
      _commentFocusNode!.requestFocus();
    }
    notifyListeners(); // 通知所有依赖于此ChangeNotifier的widget
  }
}

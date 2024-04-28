

import 'package:flutter/material.dart';
import 'package:wpr_ccpc_4_12/usermodel/user.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners(); // 当用户数据改变时，通知所有监听器
  }
}


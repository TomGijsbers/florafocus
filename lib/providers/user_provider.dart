import 'package:florafocus/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user;

  UserProvider(this._user);

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

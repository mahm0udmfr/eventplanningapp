import 'package:eventplanningapp/models/users_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UsersModel? currentUser;
  
  void updateUser(UsersModel newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}

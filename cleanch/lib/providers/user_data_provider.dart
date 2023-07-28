import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  String username = '';
  String email = '';
  String phoneNumber = '';

  void setEmail(String mail) {
    email = mail;
    notifyListeners();
  }

  void setPhoneNumber(String number) {
    phoneNumber = number;
    notifyListeners();
  }

  void setFirstName(String firstName) {
    username = firstName;
    notifyListeners();
  }
}

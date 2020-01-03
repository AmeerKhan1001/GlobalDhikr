import 'package:flutter/material.dart';

class EmailPass extends ChangeNotifier {
  String email = 'Some email', password  = 'Some pass';

  void updateEmailPassword({String email,String password})
  {
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  String get displayEmail
  {
    return email;
  }

  String get displayPass
  {
    return password;
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserCredential? _userCredential;

  UserCredential? get userCredential {
    return _userCredential;
    print(_userCredential);
  }

  void setUserCredential(UserCredential userCredential) {
    _userCredential = userCredential;

    notifyListeners();
  }
}
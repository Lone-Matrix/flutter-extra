import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyName with ChangeNotifier {
  static var myName = 'User';

  Future<void> addName(
    String name,
  ) async {
    myName = name;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('_userName', myName);
    notifyListeners();
  }

  String get userName {
    return myName;
  }
}

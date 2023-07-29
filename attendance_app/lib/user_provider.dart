import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String? uid; // User ID

  void setUser(String uid) {
    this.uid = uid;
    notifyListeners();
  }

  void clearUser() {
    this.uid = null;
    notifyListeners();
  }
}

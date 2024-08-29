import 'package:flutter/material.dart';

class UserIdProvider with ChangeNotifier {
  String? _userId;

  String? get userId => _userId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners(); // แจ้งให้วิดเจ็ตอื่น ๆ รู้ว่ามีการเปลี่ยนแปลง
  }
}

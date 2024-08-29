import 'package:flutter/material.dart';

class AnotherProvider with ChangeNotifier {
  // คลาสตัวอย่างสำหรับ provider อื่นๆ
  int _count = 0;

  int get count => _count;

  void increment(int number) {
    _count=number;
    notifyListeners(); // แจ้งเตือนผู้ฟังเมื่อข้อมูลเปลี่ยน
  }
}
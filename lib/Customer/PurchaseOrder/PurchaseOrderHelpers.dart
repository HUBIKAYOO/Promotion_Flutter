import 'package:flutter/material.dart';

BoxDecoration getContainerDecoration(String puoderStatusId) {
  switch (puoderStatusId) {
    case '1':
      return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.orange,
      );

    case '3':
      return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.orange,
      );
    default:
      return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all( color: Color.fromARGB(255, 162, 162, 162),width: 2)
      );
  }
}

Text getStatusText(String puoderStatusId) {
  switch (puoderStatusId) {
    case '1':
      return Text(
        "ชำระเงิน",
        style: TextStyle(fontSize: 18), // เพิ่มสไตล์ที่ต้องการ
      );

    case '3':
      return Text(
        'ใช้สิทธ์',
        style: TextStyle(fontSize: 18), // เพิ่มสไตล์ที่ต้องการ
      );

    case '4':
      return Text(
        'เสร็จเเล้ว',
        style: TextStyle(fontSize: 18, color: Color(0xFF4F4E4E)), // เพิ่มสไตล์ที่ต้องการ
      );

    default:
      return Text(
        'ให้คะเเนน',
        style: TextStyle(fontSize: 18, color: Color(0xFF4F4E4E)), // เพิ่มสไตล์ที่ต้องการ
      );
  }
}


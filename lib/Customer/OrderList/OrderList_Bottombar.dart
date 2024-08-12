import 'package:flutter/material.dart';
import 'package:upro/Customer/mymenu.dart';

class OrderList_Bottombar extends StatelessWidget {
  final Map<String, dynamic> data;
  const OrderList_Bottombar({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.blueAccent,
      child: Row(
        children: [
          // ข้อความ "ยอดที่ต้องชำระ" ที่ครอบคลุม 3/4 ของพื้นที่
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.0), // เพิ่ม padding ถ้าต้องการ
              alignment: Alignment
                  .centerLeft, // จัดข้อความ "ยอดที่ต้องชำระ" ให้อยู่ทางซ้าย
              child: Text(
                "ยอดที่ต้องชำระ ฿${data['price']}",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white), // เปลี่ยนสีเป็นสีขาวเพื่อให้ชัดเจน
              ),
            ),
          ),
          // ข้อความ "ซื้อ" ที่สามารถกดเพื่อไปที่ widget อื่น และครอบคลุม 1/4 ของพื้นที่
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                // ใส่โค้ดเพื่อไปที่ widget อื่น
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyMenu()),
                  (Route<dynamic> route) => false, // ลบหน้าทั้งหมดในสแต็ก
                );
              },
              child: Container(
                alignment: Alignment.center, // จัดข้อความ "ซื้อ" ให้อยู่ตรงกลาง
                color: Colors.amber,
                child: Text(
                  "ซื้อ",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue, // สีฟ้าทำให้ดูเหมือนเป็นลิงก์
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:upro/Customer/OrderList/OrderList.dart';

class Basket_Bottom extends StatelessWidget {
  List<dynamic> selectedStores;
  Map<int, List<dynamic>> selectedOrders;
  int total;
  final Map<int, List<bool>> BasketOderBool;
  final Function(bool) onStoreCheckboxChanged;
  Basket_Bottom(
      {required this.selectedOrders,
      required this.selectedStores,
      required this.total,
      required this.BasketOderBool,
      required this.onStoreCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 60,
      child: Row(
        children: [
          Transform.scale(
            scale: 1, // ปรับขนาดของ Checkbox
            child: CheckboxTheme(
              data: CheckboxThemeData(
                side: BorderSide(
                    color: Color(0xFFB7B7B7),
                    width: 2), // กำหนดสีและความหนาของขอบ
              ),
              child: Checkbox(
                value: BasketOderBool.isNotEmpty &&
                    BasketOderBool.values.every(
                        (orderList) => orderList.every((val) => val == true)),
                activeColor: Colors.orange,
                onChanged: (bool? value) {
                  onStoreCheckboxChanged(value ?? false);
                },
              ),
            ),
          ),
          Text("เลือกทั้งหมด"),
          Expanded(
  child: Container(
    padding: EdgeInsets.only(right: 10),
    alignment: Alignment.centerRight,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'รวมทั้งหมด ',
           // ฟอนต์สำหรับข้อความนี้
        ),
        Text(
          '฿$total',
          style: TextStyle(fontSize: 16, color: Colors.orange), // สีล้มสำหรับข้อความนี้
        ),
      ],
    ),
  ),
),

          InkWell(
            onTap: () {
              // ตรวจสอบว่าใน BasketOderBool มีค่า true อย่างน้อยหนึ่งอัน
              bool hasSelectedOrder = BasketOderBool.values
                  .any((orderList) => orderList.any((val) => val == true));

              if (hasSelectedOrder) {
                // ถ้ามีค่า true อันใดอันหนึ่ง
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderList(
                        store: selectedStores, // ส่งข้อมูลร้านค้าที่เกี่ยวข้อง
                        data: selectedOrders, // ส่งข้อมูลที่กรองแล้ว
                        Basket: true,
                        ),
                  ),
                );
              }
            },
            child: Container(
              color: Colors.orange,
              height: double.infinity,
              alignment: Alignment.center,
              width: 100,
              child: Text("สั่งซื้อ"),
            ),
          ),
        ],
      ),
    );
  }
}

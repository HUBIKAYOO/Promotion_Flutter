import 'package:flutter/material.dart';
import 'package:upro/Customer/PurchaseOrder/PurchaseOrder_List.dart';

class PurchaseOrder extends StatelessWidget {
  const PurchaseOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Color(0xFFEEEEEE),
          appBar: AppBar(
            title: Text('ใบสั่งซื้อ'),
            bottom: const TabBar(
              indicatorColor: Colors.orange, // สีของ indicator
              labelColor: Colors.orange, // สีของข้อความใน Tab ที่ถูกเลือก
              tabs: [
                Tab(text: 'ทั้งหมด'),
                Tab(text: 'รอชำระเงิน'),
                Tab(text: 'ชำระเเล้ว'),
                Tab(text: 'ยกเลิก'),
              ],
            ),
          ),
          body:  TabBarView(children:[
    SingleChildScrollView(
      child: PurchaseOrder_List(POStatus: "4"),
    ),
    SingleChildScrollView(
      child: PurchaseOrder_List(POStatus: "1"),
    ),
    SingleChildScrollView(
      child: PurchaseOrder_List(POStatus: "3"),
    ),
    SingleChildScrollView(
      child: PurchaseOrder_List(POStatus: "2"),
    ),
  ],),
        ));
  }
}

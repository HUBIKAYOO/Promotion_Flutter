import 'package:flutter/material.dart';
import 'package:upro/Customer/Main/Main_Promotion.dart';
import 'package:upro/Customer/PurchaseOrderDetails/POD_Oder.dart';
import 'package:upro/Customer/PurchaseOrderDetails/POD_Store.dart';

class POD extends StatefulWidget {
  String storeName;
  List<dynamic> orderDetails;
   POD({required this.storeName, required this.orderDetails});

  @override
  State<POD> createState() => _PODState();
}

class _PODState extends State<POD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดการสั่งซื่อ'),
      ),
      body: SingleChildScrollView(
        child: Container(width: double.infinity,
          color: Color(0xFFEEEEEE),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              POD_Store(storeName:widget.storeName),
              SizedBox(height: 10),
              POD_Oder(orderDetails:widget.orderDetails),
              Main_Promostion()
            ],
          ),
        ),
      ),
    );
  }
}

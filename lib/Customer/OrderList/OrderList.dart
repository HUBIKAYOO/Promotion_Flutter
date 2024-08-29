import 'package:flutter/material.dart';
import 'package:upro/Customer/OrderList/OrderList_Oder.dart';
import 'package:upro/Customer/OrderList/OrderList_Payment.dart';
import 'package:upro/Customer/OrderList/orderlist_address.dart';
import 'package:upro/Customer/OrderList/orderlist_bottombar.dart';

class OrderList extends StatefulWidget {
    final Map<String, dynamic> data;
     Set<int>? selectedIds;
  OrderList({required this.data ,this.selectedIds});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    print('object${widget.selectedIds.toString()}');
    return Scaffold(
      appBar: AppBar(
        title: Text("ทำรายการ"),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.amberAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Orderlist_Address(data:widget.data),
            Orderlist_Oder(data:widget.data),
            Orderlist_Payment(data:widget.data)
          ],
        ),
      ),
      bottomNavigationBar: OrderList_Bottombar(data:widget.data),
    );
  }
}

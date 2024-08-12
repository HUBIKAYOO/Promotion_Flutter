import 'package:flutter/material.dart';

class Orderlist_Payment extends StatelessWidget {
    final Map<String, dynamic> data;

  const Orderlist_Payment({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10,right: 10,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ข้อมูลการชำระเงิน'),
          Container(
            padding: EdgeInsets.only(top: 10,left: 10),
            color: Colors.blue,
            child: Column(
              children: [
                Row(children: [
                  Text("ราคา"),
                  Spacer(), 
                  Text('฿${data["price"]}')
                ],),
                Row(children: [
                  Text("ราคาจริง"),
                  Spacer(), 
                  Text('฿${data["price"]}')
                ],),
                Row(children: [
                  Text("ราคาโปร"),
                  Spacer(), 
                  Text('฿${data["price"]}')
                ],),
              ],
            ),
          )
        ],
      ),
    );
  }
}
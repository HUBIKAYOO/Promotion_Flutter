import 'package:flutter/material.dart';

class Orderlist_Payment extends StatelessWidget {
  final int totalSum;
  final int sumOder;

  Orderlist_Payment({required this.totalSum, required this.sumOder});

  @override
  Widget build(BuildContext context) {
    return Container(
decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ข้อมูลการชำระเงิน',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only( left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Text("รายการทั้งหมด"),
                //     Spacer(),
                //     Text('฿$sumOder')
                //   ],
                // ),
                Row(
                  children: [
                    Text("รายการรวม"),
                    Spacer(),
                    Text('x$totalSum')
                  ],
                ),
                Row(
                  children: [
                    Text("ยอดที่ต้องชำระเงินทั้งหมด", style: TextStyle(fontSize: 17)),
                    Spacer(),
                    Text('฿$sumOder', style: TextStyle(fontSize: 17,color: Colors.orange))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

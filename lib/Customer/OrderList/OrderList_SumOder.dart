import 'package:flutter/material.dart';

class Orderlist_Sumoder extends StatelessWidget {
  int? total;
  int? sumtotal;
  int? sumOder;
  int? sumsumOder;
  Orderlist_Sumoder({this.total, this.sumOder, this.sumsumOder, this.sumtotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Spacer(),
          if (total != null && sumOder != null) ...[
            Text("โปร $total "),
            Text("รายการ ฿${sumOder}"),
          ] else ...[
            Text("โปร $sumtotal ",style: TextStyle(fontSize: 15)),
            Text("รายการ ฿$sumsumOder",style: TextStyle(fontSize: 15)),
          ],
        ],
      ),
    );
  }
}

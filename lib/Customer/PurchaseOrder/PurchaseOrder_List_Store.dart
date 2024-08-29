import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:upro/Customer/PurchaseOrderDetails/POD.dart';

class PurchaseOrder_List_Store extends StatelessWidget {
  String storeName;
  List<dynamic> orderDetails;
  PurchaseOrder_List_Store(
      {required this.storeName, required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: _buildNameStore(context,storeName,orderDetails),
    );
  }
}

_buildNameStore(BuildContext context,String storeName, List<dynamic> orderDetails) => Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            storeName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => POD(storeName:storeName,orderDetails:orderDetails)));
            },
            child: Text('ดูรายละเอียด >',style: TextStyle(color: Colors.orange),),
          ),
        ],
      ),
    );

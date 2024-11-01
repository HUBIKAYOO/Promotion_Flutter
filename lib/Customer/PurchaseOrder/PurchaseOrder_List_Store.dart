import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:upro/Customer/PurchaseOrderDetails/POD.dart';

class PurchaseOrder_List_Store extends StatelessWidget {
  int storesrId;
  String? pco_detail;
  String storeName;
  List<dynamic>? orderDetails;
  final double puchaseoder_ttprice;
  PurchaseOrder_List_Store(
      {required this.storeName,
      required this.orderDetails,
      required this.puchaseoder_ttprice,
      this.pco_detail,required this.storesrId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child:
          _buildNameStore(context, storeName, orderDetails, puchaseoder_ttprice, pco_detail,storesrId),
    );
  }
}

_buildNameStore(BuildContext context, String storeName,
        List<dynamic>? orderDetails, double puchaseoder_ttprice, String? pco_detail,int storesrId) =>
    Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            storeName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          if (orderDetails != null)
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => POD(
                          storesrId:storesrId,
                              pco_detail: pco_detail,
                              storeName: storeName,
                              orderDetails: orderDetails,
                              puchaseoder_ttprice: puchaseoder_ttprice,
                            )));
              },
              child: Text(
                'ดูรายละเอียด >',
                style: TextStyle(color: Colors.orange),
              ),
            ),
        ],
      ),
    );

import 'package:flutter/material.dart';

class PurchaseOrder_List_Totol extends StatelessWidget {
  String puoderStatusId;
  PurchaseOrder_List_Totol({required this.puoderStatusId});

  @override
  Widget build(BuildContext context) {
    // ใช้ฟังก์ชันเพื่อกำหนดลักษณะของ Container ตามสถานะ
    final decoration = _getContainerDecoration(puoderStatusId);
    final statusText = _getStatusText(puoderStatusId);
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("สินค้ารวม 1 "),
              Text("รายการ ฿66"),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    statusText,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  decoration: decoration,
                  width: 150,
                  height: 30,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

BoxDecoration _getContainerDecoration(String puoderStatusId) {
  switch (puoderStatusId) {
    case '1':
      return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.orange,
      );
    case '2':
      return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      );
    case '3':
      return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.green,
      );
    default:
      return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.green,
      );
  }
}

String _getStatusText(String puoderStatusId) {
  switch (puoderStatusId) {
    case '1':
      return "รอการชำระ";
    case '2':
      return 'ยกเลิก';
    case '3':
      return 'ชำระเเล้ว';
    default:
      return 'Unknown Status';
  }
}

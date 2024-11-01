import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:upro/IP.dart';

class PurchaseOrder_List_Oder extends StatelessWidget {
  Map<String, dynamic> item;
  PurchaseOrder_List_Oder({required this.item});

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls =
        List<String>.from(json.decode(item['images'] ?? '[]'));

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 80,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  5), // เปลี่ยนค่าเพื่อปรับความโค้งมนของมุม
              child: imageUrls.isNotEmpty
                  ? Image.network(
                      'http://$IP/productimages/${imageUrls[0]}',
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 80,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(color: Colors.grey),
                      ),
                      Spacer(),
                      Text("x${item['repeated']}",
                          style: TextStyle(color: Colors.grey))
                    ],
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Spacer(),
                        Text("฿${item['price']}",
                            style: TextStyle(fontSize: 15))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:upro/IP.dart';

class Orderlist_Oder extends StatelessWidget {
  Map<String, dynamic> item;
  String? selectedMenuDetailName;
  double? puchaseoder_ttprice; 
  Orderlist_Oder({required this.item, this.selectedMenuDetailName,this.puchaseoder_ttprice});

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
                        item['menu_detail_data'] != "ไม่มี"
                            ? item['menu_detail_data']
                            : "",
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
                        Text("฿${(item['totalprice'] != null ? double.parse(item['totalprice'].toString()) : double.parse(item['price'].toString())).toInt()}"
,
                            style: TextStyle(fontSize: 17,color: Colors.orange)),
                        Spacer(),
                        Text(item['promo_name'],
                            style: TextStyle(fontSize: 15,color: Colors.grey)),
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

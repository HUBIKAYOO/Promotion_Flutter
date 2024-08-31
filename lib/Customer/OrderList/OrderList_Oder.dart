import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:upro/IP.dart';

class Orderlist_Oder extends StatelessWidget {
  final Map<String, dynamic> data;
  final List<dynamic>? oderStatus1 ;
  Orderlist_Oder({required this.data ,required this.oderStatus1});

  late Map<String, dynamic> _data = data;

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = [];
    try {
      images = json.decode(_data['images']);
    } catch (e) {
      print('Error parsing images: $e');
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      margin: EdgeInsets.all(10),
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("รายการ"),
          Container(
            color: Colors.orange,
            width: double.infinity,
            margin: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  color: Colors.transparent,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          5), // เปลี่ยนค่าเพื่อปรับความโค้งมนของมุม
                      child: Image.network(
                        'http://$IP/productimages/${images[0]}',
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_data["name"]),
                    Text('฿${_data['price']}'),
                    Text("x1"),
                  ],
                ),
              ],
            ),
          ),
          if (oderStatus1 !=null) // เช็คว่ามีข้อมูลใน _oderStatus1 หรือไม่
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("รายการที่รอชำระ"), // แสดงข้อความ "lll"
                ...oderStatus1!.map((order) {
                  // แปลงข้อมูล 'images' ภายใน map
                  List<dynamic> imagesoder = [];
                  try {
                    imagesoder = json.decode(order['images']);
                  } catch (e) {
                    print('Error parsing images from order: $e');
                  }

                  // สร้าง Widget ตามจำนวนรายการใน _oderStatus1
                  return Container(
                    color: Colors.orange,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        top: 5, bottom: 10, left: 10, right: 10),
                    child: Row(
                      children: [
                        if (imagesoder.isNotEmpty)
                          Container(
                            height: 80,
                            width: 80,
                            color: Colors.transparent,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    5), // เปลี่ยนค่าเพื่อปรับความโค้งมนของมุม
                                child: Image.network(
                                  'http://$IP/productimages/${imagesoder[0]}',
                                  fit: BoxFit.cover,
                                )),
                          ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order["name"]),
                            Text('฿${order['price']}'),
                            Text("x1"),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            )
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:upro/Customer/promostion/promostion_choose_popup.dart';
import 'package:upro/IP.dart';

class Promostion_Bottombar extends StatelessWidget {
  Map<String, dynamic> data;
  Promostion_Bottombar({required this.data});

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = [];
    try {
      images = json.decode(data['images']);
    } catch (e) {
      print('Error parsing images: $e');
    }

    return Container(
      height: 60,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'http://$IP/productimages/${images[0]}',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 3),  
                    Text(
                      "ร้าน",
                      style: TextStyle(fontSize: 10, color: Color(0xFF535353)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: VerticalDivider(color: Colors.grey),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // ให้ Popup ปรับขนาดตามเนื้อหา
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10)), // กำหนดรัศมีที่นี่
                  ),
                  builder: (BuildContext context) {
                    return Promostion_Choose_Popup(
                        data: data, Type: 'เก็บในตะกร้า');
                  },
                );
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Colors.orange,
                      size: 30,
                    ),
                    Text(
                      "เก็บในตะกร้า",
                      style: TextStyle(fontSize: 10, color: Color(0xFF535353)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // ปรับขนาดตามเนื้อหา
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10)), // กำหนดรัศมีที่นี่
                  ),
                  builder: (BuildContext context) {
                    return Promostion_Choose_Popup(
                      data: data,
                      Type: 'ซื้อเลย',
                      // typeList: _type, // ส่งข้อมูล _type ไปที่ Popup
                    );
                  },
                );
              },
              child: Container(
                height: double.infinity,
                color: Colors.orange,
                child: Center(
                  child: Text(
                    'ซื้อเลย',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

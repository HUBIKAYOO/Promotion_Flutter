import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:upro/ip.dart';

class Orderlist_Oder extends StatefulWidget {
  final Map<String, dynamic> data;
  Orderlist_Oder({required this.data});

  @override
  _Orderlist_OderState createState() => _Orderlist_OderState();
}

class _Orderlist_OderState extends State<Orderlist_Oder> {
  late Map<String, dynamic> _data = widget.data;

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
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Image.network(
                  'http://$ip/productimages/${images[0]}',
                  width: 120,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_data["name"]),
                    Text('฿${_data['price']}'),
                    Text("x1")
                    
                      
                    
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

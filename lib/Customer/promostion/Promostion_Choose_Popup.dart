import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:upro/Customer/OrderList/OrderList.dart';
import 'package:upro/ip.dart';



class Promostion_Choose_Popup extends StatelessWidget {
  final Map<String, dynamic> data;


  Promostion_Choose_Popup({required this.data});

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = [];
    try {
      images = json.decode(data['images']);
    } catch (e) {
      print('Error parsing images: $e');
    }
    List<String> type = ['น้ำข้น', 'น้ำใส', 'น้ำหวาน'];

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      height: 200,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                child: Image.network(
                  'http://$ip/productimages/${images[0]}',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Text(
                    "฿${data['price']}",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                  Text(
                    "฿${data['price']}",
                    style: TextStyle(
                        fontSize: 15, decoration: TextDecoration.lineThrough),
                  )
                ],
              ),
              SizedBox(
                width: 100,
              ),
              Row(
                children: [
                  Text("-"),
                  Text("1"),
                  Text("+"),
                ],
              )
            ],
          ),
          Row(
            children: type.map((typeItem) {
              return Container(
                color: Colors.blue,
                margin: const EdgeInsets.all(8.0),
                child: Text(
                  typeItem,
                  style: TextStyle(fontSize: 16.0),
                ),
              );
            }).toList(),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderList(data:data)));
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 30,
              color: Colors.orange,
              child: Text("จอง"),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:upro/IP.dart';

class POD_Oder extends StatelessWidget {
  List<dynamic> orderDetails;
  POD_Oder({required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.blue,
      child: Column(
        children: orderDetails.map((item) {
          List<String> imageUrls =
              List<String>.from(json.decode(item['images'] ?? '[]'));

          return Container(
            color: Colors.blue,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.amber,
                  child: imageUrls.isNotEmpty
                      ? Image.network(
                          'http://$IP/productimages/${imageUrls[0]}',
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 100,
                    color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(item['name']),
                            Spacer(),
                            Text("x${item['oder_amount']}")
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '฿${item['price']}',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 20),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '฿${item['totalprice']}',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

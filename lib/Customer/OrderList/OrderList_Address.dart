import 'package:flutter/material.dart';

class Orderlist_Address extends StatelessWidget {
  final Map<String, dynamic> data;

  const Orderlist_Address({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFEEEEEE),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.location_on,color: Colors.red,), // ไอคอนที่ต้องการใส่
                SizedBox(width: 10), // ระยะห่างระหว่างไอคอนกับข้อความ
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data["storeName"]),
                        Text('0987311145'),
                        Text('${data["name"]} ต.ปากู จ.ปัตตานี 95000')
                      ],
                    ),
                  ),
                ),
                Text('>',style: TextStyle(fontSize: 18),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

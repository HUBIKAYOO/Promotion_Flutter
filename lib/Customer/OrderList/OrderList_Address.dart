import 'package:flutter/material.dart';

class Orderlist_Address extends StatelessWidget {
  final Map<String, dynamic> data;

  const Orderlist_Address({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.all(10),
      color: Colors.red,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.orange,
            child: Text(
              "ร้าน",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20,top: 10),
            color: Colors.blue,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.add_home_rounded), // ไอคอนที่ต้องการใส่
                SizedBox(width: 10), // ระยะห่างระหว่างไอคอนกับข้อความ
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data["name"]),
                      Text('0987311145'),
                      Text('${data["name"]} ต.ปากู จ.ปัตตานี 95000')
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

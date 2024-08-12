import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:upro/Customer/promostion/promostion.dart';
import 'package:upro/ip.dart';

class Main_Promostion extends StatefulWidget {
  const Main_Promostion({super.key});

  @override
  State<Main_Promostion> createState() => _Main_PromostionState();
}

class _Main_PromostionState extends State<Main_Promostion> {
  //เอาไว้เก็บข้อมูลapiที่ได้รับ
  List<dynamic> _attractions = [];

  //api
  Future<void> _fetchAttractions() async {
    try {
      final response =
          await http.get(Uri.parse('http://$ip/setpromotionslist'));

      if (response.statusCode == 200) {
        setState(() {
          _attractions = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  //รีทุกครั้งที่เข้ามา
  @override
  void initState() {
    super.initState();
    _fetchAttractions();
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth = (MediaQuery.of(context).size.width - 40) /
        2; // กำหนดความกว้างของแต่ละรายการ
    return Container(
      color: Colors.blue,
      child: Wrap(
        spacing: 10, // ระยะห่างระหว่างรายการ
        runSpacing: 10, // ระยะห่างระหว่างบรรทัด
        children: _attractions.map((item) {
          // แปลงสตริง JSON เป็นอาเรย์
          List<dynamic> images = [];
          try {
            images = json.decode(item['images']);
          } catch (e) {
            print('Error parsing images: $e');
          }

          final url = images[0];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Promostion(data: item), // ส่งค่าที่ต้องการ
                ),
              );
            },
            child: Container(
              width: itemWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      'http://$ip/productimages/$url',
                      width: itemWidth,
                      height: itemWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ), // ระยะห่างระหว่างรูปภาพกับข้อความ
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '฿${item['cost_price']}',
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

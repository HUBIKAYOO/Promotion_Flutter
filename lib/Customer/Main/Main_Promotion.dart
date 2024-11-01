import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:upro/Customer/promostion/promostion.dart';
import 'package:upro/IP.dart';

class Main_Promostion extends StatefulWidget {
  const Main_Promostion({super.key});

  @override
  State<Main_Promostion> createState() => _Main_PromostionState();
}

class _Main_PromostionState extends State<Main_Promostion> {
  // เอาไว้เก็บข้อมูลapiที่ได้รับ
  List<dynamic> _attractions = [];

  // api
  Future<void> _fetchAttractions() async {
    try {
      final response = await http.get(Uri.parse('http://$IP/setpromotionslist'));

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

  // รีทุกครั้งที่เข้ามา
  @override
  void initState() {
    super.initState();
    _fetchAttractions();
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth = (MediaQuery.of(context).size.width - 40) / 2; // กำหนดความกว้างของแต่ละรายการ

    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,
      color: Colors.transparent,
      child: Center(
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
                    builder: (context) => Promostion(data: item), // ส่งค่าที่ต้องการ
                  ),
                );
              },
              child: Container(
                width: itemWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            'http://$IP/productimages/$url',
                            width: itemWidth,
                            height: itemWidth,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                color: Colors.white.withOpacity(0.5),
                                child: Text(
                                  '${item['promo_name']}'
                                  ,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5), // ระยะห่างระหว่างรูปภาพกับข้อความ
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['name']),
                          Row(children: [
                            Text(
                            '฿${item['price']} ',
                            style: TextStyle(color: Colors.orange),
                          ),
                          Text(
                            '฿${item['oprice']}',
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),

                          ],)
                          ,
                          Row(
                            children: [
                              Text(
                                'ประหยัด฿${item['oprice'] - item['price']}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Text(
                          //       'โปรเหลือ${item['oprice'] }'
                          //     ),
                              
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

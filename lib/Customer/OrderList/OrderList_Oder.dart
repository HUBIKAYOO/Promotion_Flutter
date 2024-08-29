import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upro/Customer/OrderList/oderStatus1.dart';
import 'package:upro/IP.dart';
import 'package:upro/SignIn/Login/UserID.dart';


class Orderlist_Oder extends StatefulWidget {
  final Map<String, dynamic> data;
  Orderlist_Oder({required this.data});

  @override
  _Orderlist_OderState createState() => _Orderlist_OderState();
}

class _Orderlist_OderState extends State<Orderlist_Oder> {
  late Map<String, dynamic> _data = widget.data;
  List<dynamic> _oderStatus1 = [];

  late OderStatus1 _oderStatus1Manager;

  @override
  void initState() {
    super.initState();
    _oderStatus1Manager = OderStatus1();
    _fetchAttractions();
  }

  Future<void> _fetchAttractions() async {
    try {
      final userId = Provider.of<UserIdProvider>(context, listen: false).userId;

      final response = await http.get(Uri.parse(
          'http://$IP/puchaseoder/store/${_data['storeId']}/status/1/user/$userId'));
      print('Response: $response');

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        Map<String, dynamic> firstItem = data[0];
        String purchaseorderId = firstItem['puchaseoder_id'].toString();
        print('Purchase Order ID: $purchaseorderId');

        final responses = await http
            .get(Uri.parse('http://$IP/orders/puchaseorder/$purchaseorderId'));

        if (responses.statusCode == 200) {
          setState(() {
            _oderStatus1 = json.decode(responses.body);
            _oderStatus1Manager.setOderStatus1(_oderStatus1); // อัพเดต OderStatus1
          });
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

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
          if (_oderStatus1.isNotEmpty) // เช็คว่ามีข้อมูลใน _oderStatus1 หรือไม่
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("รายการที่รอชำระ"), // แสดงข้อความ "lll"
                ..._oderStatus1.map((order) {
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

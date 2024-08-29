import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // นำเข้าชุดคำสั่งสำหรับจัดการวันที่และเวลา
import 'package:upro/Customer/MyMenu.dart';
import 'package:upro/IP.dart';
import 'package:upro/SignIn/Login/UserID.dart';

class OrderList_Bottombar extends StatelessWidget {
  final Map<String, dynamic> data;
  const OrderList_Bottombar({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);
    return Container(
      height: 60,
      color: Colors.blueAccent,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                "ยอดที่ต้องชำระ ฿${data['price']}",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                _insert(context);
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.amber,
                child: Text(
                  "ซื้อ",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _insert(BuildContext context) async {
    String url = "http://$IP/puchaseoder_register";
    final userId = Provider.of<UserIdProvider>(context, listen: false).userId;

    // ใช้วันที่และเวลาปัจจุบัน
    String currentDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    print('aaaaaaaaaaaa$currentDate');
    Map<String, dynamic> data = {
      'user_id': userId,
      'storeId': this.data['storeId'].toString(),
      'puchaseoder_date': currentDate, // ใช้วันที่และเวลาปัจจุบัน
      'puoder_status_id': '1',
      'puchaseoder_ttprice': '50.30',
      'compostore_id': '0',
    };

    final response = await http.post(Uri.parse(url), body: data);

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      var puchaseoderId = jsonResponse['puchaseoderId'];
      print('รหัสใบสั่งซื้อ: $puchaseoderId');

      String url2 = "http://$IP/oder_register";
      Map<String, dynamic> data2 = {
        'set_promotion_id': this.data['set_promotion_id'].toString(),
        'totalprice': '50.30',
        'puchaseoder_id': puchaseoderId.toString(),
        'order_status_id': '1',
        'oder_amount': this.data['amountcon'].toString(),
        'price': this.data['price'].toString(),
        'price_setpro': '60',
        'menu_data_id': '1',
        'purchasetype_id': '2',
        'order_detail': '',
      };

      final response2 = await http.post(Uri.parse(url2), body: data2);

      print("${url2}xxx${data2}");

      if (response2.statusCode == 201) {
        var jsonResponse2 = jsonDecode(response2.body);
        var oderId = jsonResponse2['oderId'];
        print('รหัสใบสั่ง: $oderId');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyMenu(
              menu: 1,
            ),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } else {
      print(
          'การอัพโหลดข้อมูลและรูปภาพล้มเหลว รหัสสถานะ: ${response.statusCode}');
    }
  }
}

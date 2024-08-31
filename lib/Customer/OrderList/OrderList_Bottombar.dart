import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:upro/Customer/MyMenu.dart';
import 'package:upro/IP.dart';
import 'package:upro/SignIn/Login/UserID.dart';
import 'package:http/http.dart' as http;

class OrderList_Bottombar extends StatelessWidget {
  final Map<String, dynamic> data;
  final double? sumOder;
  final String? purchaseorderId;

  OrderList_Bottombar(
      {required this.data,
      required this.sumOder,
      required this.purchaseorderId});

  @override
  Widget build(BuildContext context) {
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
                "ยอดที่ต้องชำระ ฿${sumOder != null ? sumOder!.toStringAsFixed(2) : data['price']}",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                _insert(context); // ส่ง context ไปยัง _insert()
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
    String url2 = "http://$IP/oder_register";
    final userId = Provider.of<UserIdProvider>(context, listen: false).userId;
    String currentDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    if (sumOder == null) {
      Map<String, dynamic> puchaseoder = {
        'user_id': userId,
        'storeId': data['storeId'].toString(),
        'puchaseoder_date': currentDate,
        'puoder_status_id': '1',
        'puchaseoder_ttprice': '50.30',
        'compostore_id': '0',
      };
      String url = "http://$IP/puchaseoder_register";
      final response = await http.post(Uri.parse(url), body: puchaseoder);
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        var _puchaseoderId = jsonResponse['puchaseoderId'];
        print('รหัสใบสั่งซื้อ: $_puchaseoderId');

        Map<String, dynamic> Oder = {
          'set_promotion_id': data['set_promotion_id'].toString(),
          'totalprice': '50.30',
          'puchaseoder_id': _puchaseoderId.toString(),
          'order_status_id': '1',
          'oder_amount': data['amountcon'].toString(),
          'price': data['price'].toString(),
          'price_setpro': '60',
          'menu_data_id': '1',
          'purchasetype_id': '2',
          'order_detail': '',
        };

        final response2 = await http.post(Uri.parse(url2), body: Oder);
        if (response2.statusCode == 201) {
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
      }
    } else {
      Map<String, dynamic>? puchaseoder = {
        'user_id': null,
        'storeId': null,
        'puchaseoder_date': null,
        'puoder_status_id': null,
        'puchaseoder_ttprice': sumOder.toString(),
        'compostore_id': null,
      };
      String url = "http://$IP/edit_puchaseoder/$purchaseorderId";
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(puchaseoder),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> Oder = {
          'set_promotion_id': data['set_promotion_id'].toString(),
          'totalprice': '50.30',
          'puchaseoder_id': purchaseorderId,
          'order_status_id': '1',
          'oder_amount': data['amountcon'].toString(),
          'price': data['price'].toString(),
          'price_setpro': '60',
          'menu_data_id': '1',
          'purchasetype_id': '2',
          'order_detail': '',
        };
        final response2 = await http.post(Uri.parse(url2), body: Oder);
        if (response2.statusCode == 201) {
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
      }
    }
  }
}













    

//     

//     


//       

//       print("${url2}xxx${data2}");

//       if (response2.statusCode == 201) {
//         var jsonResponse2 = jsonDecode(response2.body);
//         var oderId = jsonResponse2['oderId'];
//         print('รหัสใบสั่ง: $oderId');
//         String url3 = "http://$IP/sum-prices/$puchaseoderId";
//         final response3 = await http.post(Uri.parse(url3), body: data2);


//       }
//     }
//     else {
//       String url2 = "http://$IP/oder_register";
//       var firstOrder = oderStatus1[0];
//       var puchaseoderId = firstOrder['puchaseoder_id'].toString();
//       Map<String, dynamic> data2 = {
//         'set_promotion_id': this.widget.data['set_promotion_id'].toString(),
//         'totalprice': '50.30',
//         'puchaseoder_id': puchaseoderId,
//         'order_status_id': '1',
//         'oder_amount': this.widget.data['amountcon'].toString(),
//         'price': this.widget.data['price'].toString(),
//         'price_setpro': '60',
//         'menu_data_id': '1',
//         'purchasetype_id': '2',
//         'order_detail': '',
//       };
//     }
//     } else {
//       print('การอัพโหลดข้อมูลและรูปภาพล้มเหลว รหัสสถานะ: ');
//     }
 
// // }

// // void _insert(BuildContext context) async {
// //     String url = "http://$IP/puchaseoder_register";
// //     final userId = Provider.of<UserIdProvider>(context, listen: false).userId;

// //     // ใช้วันที่และเวลาปัจจุบัน
// //     String currentDate =
// //         DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

// //     Map<String, dynamic> data = {
// //       'user_id': userId,
// //       'storeId': this.widget.data['storeId'].toString(),
//       'puchaseoder_date': currentDate, // ใช้วันที่และเวลาปัจจุบัน
//       'puoder_status_id': '1',
//       'puchaseoder_ttprice': '50.30',
//       'compostore_id': '0',
//     };

//     final response = await http.post(Uri.parse(url), body: data);

//     if (response.statusCode == 201) {
//       var jsonResponse = jsonDecode(response.body);
//       var puchaseoderId = jsonResponse['puchaseoderId'];
//       print('รหัสใบสั่งซื้อ: $puchaseoderId');

//       String url2 = "http://$IP/oder_register";
//       Map<String, dynamic> data2 = {
//         'set_promotion_id': this.widget.data['set_promotion_id'].toString(),
//         'totalprice': '50.30',
//         'puchaseoder_id': puchaseoderId.toString(),
//         'order_status_id': '1',
//         'oder_amount': this.widget.data['amountcon'].toString(),
//         'price': this.widget.data['price'].toString(),
//         'price_setpro': '60',
//         'menu_data_id': '1',
//         'purchasetype_id': '2',
//         'order_detail': '',
//       };

//       final response2 = await http.post(Uri.parse(url2), body: data2);

//       print("${url2}xxx${data2}");

//       if (response2.statusCode == 201) {
//         var jsonResponse2 = jsonDecode(response2.body);
//         var oderId = jsonResponse2['oderId'];
//         print('รหัสใบสั่ง: $oderId');
//         String url3 = "http://$IP/sum-prices/$puchaseoderId";
//         final response3 = await http.post(Uri.parse(url3), body: data2);

//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => MyMenu(
//               menu: 1,
//             ),
//           ),
//           (Route<dynamic> route) => false,
//         );
//       }
//     }
//     //else {
//     //   String url2 = "http://$IP/oder_register";
//     //   var firstOrder = oderStatus1[0];
//     //   var puchaseoderId = firstOrder['puchaseoder_id'].toString();
//     //   Map<String, dynamic> data2 = {
//     //     'set_promotion_id': this.widget.data['set_promotion_id'].toString(),
//     //     'totalprice': '50.30',
//     //     'puchaseoder_id': puchaseoderId,
//     //     'order_status_id': '1',
//     //     'oder_amount': this.widget.data['amountcon'].toString(),
//     //     'price': this.widget.data['price'].toString(),
//     //     'price_setpro': '60',
//     //     'menu_data_id': '1',
//     //     'purchasetype_id': '2',
//     //     'order_detail': '',
//     //   };
//     // }
//     // } else {
//     //   print('การอัพโหลดข้อมูลและรูปภาพล้มเหลว รหัสสถานะ: ');
//     // }
//   }

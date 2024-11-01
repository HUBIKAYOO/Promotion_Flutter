import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:upro/Customer/MyMenu.dart';
import 'package:upro/IP.dart';
import 'package:upro/SignIn/Login/UserID.dart';
import 'package:http/http.dart' as http;

class OrderList_Bottombar extends StatelessWidget {
  final Map<int, List<dynamic>> data;
  final String? purchaseorderId;
  Map<int, int> sumOder;
  String? selectedMenuDetailName;
  bool? Basket;
  final Map<int, TextEditingController> nameControllers; // เพิ่ม parameter นี้
  final ValueNotifier<bool> isProcessing =
      ValueNotifier(false); // สร้าง ValueNotifier สำหรับสถานะ

  OrderList_Bottombar({
    required this.data,
    required this.sumOder,
    required this.purchaseorderId,
    this.selectedMenuDetailName,
    this.Basket,
    required this.nameControllers,
  });

  @override
  Widget build(BuildContext context) {
    int totalSum = sumOder.values.reduce((a, b) => a + b);

    return ValueListenableBuilder<bool>(
      valueListenable: isProcessing, // เชื่อมโยงกับ ValueNotifier
      builder: (context, processing, child) {
        return Container(
          height: 60,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ยอดที่ต้องชำระทั้งหมด ",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      Text(
                        "฿$totalSum",
                        style: TextStyle(fontSize: 20, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: processing // ปิดการกดปุ่มถ้ากำลังทำงาน
                      ? null
                      : () async {
                          isProcessing.value =
                              true; // ตั้งสถานะเป็นกำลังประมวลผล
                          await _insert(
                              context, data); // เรียกใช้ฟังก์ชัน insert
                          isProcessing.value =
                              false; // ตั้งสถานะกลับเป็นไม่ประมวลผล
                        },
                  child: Container(
                    alignment: Alignment.center,
                    color: processing
                        ? Colors.grey
                        : Colors.orange, // เปลี่ยนสีปุ่ม
                    child: Text(
                      "ซื้อ",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _insert(BuildContext context, data) async {
    final userId = Provider.of<UserIdProvider>(context, listen: false).userId;
    String currentDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

    for (var entry in data.entries) {
      print("sumOder : $sumOder");
      int storeId = entry.key;
      List<dynamic> listoder = entry.value;

      final checkpuchaseoder = await http
          .get(Uri.parse('http://$IP/puchaseoder/check/$userId/$storeId'));
      if (checkpuchaseoder.statusCode == 200) {
        int purchaseorderId = json.decode(checkpuchaseoder.body);

        // ไม่มี puchaseoder
        if (purchaseorderId == 0) {
          await _insertNoPuchaser(userId, storeId, currentDay, sumOder[storeId],
              currentTime, nameControllers[storeId], listoder);
        }
        // มี puchaseoder ที่ยังไม่จ่าย
        else {
          await _insertHavePuchaser(sumOder[storeId], currentTime,
              nameControllers[storeId], purchaseorderId, listoder);
        }
      }
      
    }
    // หลังจากทำงานเสร็จจะกลับไปที่หน้าหลัก
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MyMenu(
          menu: 1,
        ),
      ),
      (Route<dynamic> route) => false,
    );
    // Navigator.pushAndRemoveUntil(
    // context,
    // MaterialPageRoute(
    //   builder: (context) => MyMenu(
    //     menu: 1,
    //   ),
  //   ),
  //   (Route<dynamic> route) => false,
  // ).then((_) {
  //   // แสดง popup QRCodeDialog หลังจากกลับไปที่หน้าหลัก
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return QRCodeDialog(
  //         amount: widget.amount,
  //         puchaseoder_id: widget.puchaseoder_id.toString(),
  //         onStatusUpdated: (Image) {
  //           setState(() {
  //             _fetchedImage = Image;
  //           });
  //         },
  //       );
  //     },
  //   );
  // });
  }

  Future<void> _insertNoPuchaser(userId, storeId, currentDay, sumOderStoreId,
      currentTime, detail, listoder) async {
    Map<String, dynamic> puchaseoder = {
      'user_id': userId.toString(),
      'storeId': storeId.toString(),
      'puchaseoder_date': currentDay,
      'puoder_status_id': '1',
      'puchaseoder_ttprice': sumOderStoreId.toString(),
      'compostore_id': '0',
      'time': currentTime,
      'pco_detail': detail?.text,
    };
    print("puchaseoder : $puchaseoder");

    String url = "http://$IP/puchaseoder_register";
    final insertpuchaseoder =
        await http.post(Uri.parse(url), body: puchaseoder);
    if (insertpuchaseoder.statusCode == 201) {
      var jsonpuchaseoder = jsonDecode(insertpuchaseoder.body);
      var _puchaseoderId = jsonpuchaseoder['puchaseoderId'];
      print('_puchaseoderId : $_puchaseoderId');

      for (var item in listoder) {
        int? MemuDataId;
        if (!item.containsKey('menu_data_id')) {
          String url = "http://$IP/menu_data_register";
          final insertMemuData = await http.post(Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: json.encode({
                'menu_detail_data':
                    item['menu_detail_data'].toString() // ส่งข้อมูลเป็น JSON
              }));

          if (insertMemuData.statusCode == 201) {
            Map<String, dynamic> responseData =
                json.decode(insertMemuData.body);
            MemuDataId = responseData['menuDataId'];
          }
        }
        print("repeated : ${item['repeated']}");

        Map<String, dynamic> Oder = {
          'set_promotion_id': item['set_promotion_id'].toString(),
          'totalprice': (item['price'] * item['repeated']).toString(),
          'puchaseoder_id': _puchaseoderId.toString(),
          'order_status_id': '1',
          'oder_amount': item['amountcon'].toString(),
          'price': item['price'].toString(), // แปลงเป็น String
          'price_setpro': '60',
          'menu_data_id': (MemuDataId ?? item['menu_data_id']).toString(),
          'purchasetype_id': '2',
          'order_detail': '',
          'count': item['repeated'].toString()
        };
        print("Oderxxx : $Oder");
        String url2 = "http://$IP/oder_register";
        final oder = await http.post(Uri.parse(url2), body: Oder);
        if (oder.statusCode == 201) {
          print("insertoser สำเร็จ");
          //ตะกร้า
      if (Basket == true) {
        await _deleteBasketAndMenu(listoder);
      }
        }
        else{
          print("insertoser ไม่สำเร็จ");
        }
      }
    }
  }

  Future<void> _insertHavePuchaser(
      sumOderStoreId, currentTime, detail, purchaseorderId, listoder) async {
    Map<String, dynamic>? puchaseoder = {
      'user_id': null,
      'storeId': null,
      'puchaseoder_date': null,
      'puoder_status_id': null,
      'puchaseoder_ttprice': sumOderStoreId.toString(),
      'compostore_id': null,
      'time': currentTime,
      'pco_detail': detail?.text,
    };
    print("puchaseoder else : $puchaseoder");
    String url = "http://$IP/edit_puchaseoder/$purchaseorderId";
    final Updatepuchaseoder = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(puchaseoder),
    );
    if (Updatepuchaseoder.statusCode == 200) {
      print('200');
      for (var items in listoder) {
        int? MemuDataId;
        String url =
            "http://$IP/check_menu_data"; // เรียกใช้ API เปรียบเทียบข้อมูล
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'menu_detail_data': items['menu_detail_data'].toString(),
            'puchaseoder_id': purchaseorderId.toString(),
            'set_promotion_id': items['set_promotion_id'].toString()
          }),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = json.decode(response.body);
          MemuDataId = responseData['menuDataId'];
          print('MemuDataId: ${MemuDataId.toString()}');
        } else {
          print('Error: ${response.statusCode}');

          String url = "http://$IP/menu_data_register";
          final insertMemuData = await http.post(Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: json.encode({
                'menu_detail_data':
                    items['menu_detail_data'].toString() // ส่งข้อมูลเป็น JSON
              }));

          if (insertMemuData.statusCode == 201) {
            Map<String, dynamic> responseData =
                json.decode(insertMemuData.body);
            MemuDataId = responseData['menuDataId'];
          }
        }
        print("repeated items : ${items['repeated']}");

        Map<String, dynamic> Oder = {
          'set_promotion_id': items['set_promotion_id'].toString(),
          'totalprice': (items['price'] * items['repeated']).toString(),
          'puchaseoder_id': purchaseorderId.toString(),
          'order_status_id': '1',
          'oder_amount': items['amountcon'].toString(),
          'price': items['price'].toString(), // แปลงเป็น String
          'price_setpro': '60',
          'menu_data_id': MemuDataId.toString(),
          'purchasetype_id': '2',
          'order_detail': '',
          'count': items['repeated'].toString()
        };
        print("oder : $Oder");
        String url2 = "http://$IP/oder_register";
        final oder = await http.post(Uri.parse(url2), body: Oder);
        if (oder.statusCode == 201) {
          print("insertoser สำเร็จ");
          //ตะกร้า
      if (Basket == true) {
        await _deleteBasketAndMenu(listoder);
      }
        }else{
          print("insertoser ไม่สำเร็จ");
        }
      }
    }
  }

  Future<void> _deleteBasketAndMenu(List<dynamic> listoder) async {
    // ลบข้อมูลใน basket
    for (var items in listoder) {
      final deleteBasket = await http.delete(
        Uri.parse('http://$IP/delete_basket/${items['basket_id']}'),
      );
      if (deleteBasket.statusCode == 200) {
        print("ลบBasketสำเร็จ");
      }
    }

    // ลบข้อมูลเมนู
    for (var itemss in listoder) {
      if (itemss['menu_data_id'] != 1) {
        final deletemenu = await http.delete(
          Uri.parse('http://$IP/delete_menu_data/${itemss['menu_data_id']}'),
        );
        if (deletemenu.statusCode == 200) {
          print("ลบMenuสำเร็จ");
        }
      }
    }
  }
}

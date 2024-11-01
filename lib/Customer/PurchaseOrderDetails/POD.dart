import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:upro/Customer/Main/Main_Promotion.dart';
import 'package:upro/Customer/OrderList/OrderList_Oder.dart';
import 'package:upro/Customer/PurchaseOrder/PurchaseOrder_List_Store.dart';
import 'package:upro/Customer/PurchaseOrderDetails/POD_Store.dart';
import 'package:http/http.dart' as http;
import 'package:upro/IP.dart';

class POD extends StatefulWidget {
  int storesrId;
  String? pco_detail;
  String storeName;
  List<dynamic> orderDetails;
  final double puchaseoder_ttprice;

  POD(
      {required this.storeName,
      required this.orderDetails,
      required this.puchaseoder_ttprice,
      this.pco_detail,
      required this.storesrId});

  @override
  State<POD> createState() => _PODState();
}

class _PODState extends State<POD> {
String phone = ''; // เก็บหมายเลขโทรศัพท์
String address = ''; // เก็บที่อยู่
  @override
  void initState() {
    super.initState();
    fetchStoreDetails(); // เรียกฟังก์ชันในการโหลดข้อมูล
  }

  Future<void> fetchStoreDetails() async {
    final url = Uri.parse(
        'http://$IP/stors?storeId=${widget.storesrId}'); // แทนที่ด้วย URL ที่ถูกต้อง
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Phone: ${data['phone']}');
        print('Address: ${data['address']}');

        // เรียกใช้งาน setState เพื่ออัพเดตค่า orderDetails
        setState(() {
          phone = data['phone'] ?? ''; // อัพเดตหมายเลขโทรศัพท์
        address = data['address'] ?? ''; // อัพเดตที่อยู่
        });
      } else {
        print('Error: ${response.statusCode}');
        final errorData = json.decode(response.body);
        print('Message: ${errorData['error']}');
      }
    } catch (e) {
      print('Error fetching store details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        title: Text('รายละเอียดการสั่งซื่อ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Color(0xFFEEEEEE),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              POD_Store(
                phone:phone ,address: address,
                storeName: widget.storeName,
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Column(
                    children: [
                      PurchaseOrder_List_Store(
                          storesrId: widget.storesrId,
                          storeName: widget.storeName,
                          orderDetails: null,
                          puchaseoder_ttprice: widget.puchaseoder_ttprice),
                      SizedBox(height: 1),
                      Divider(color: Colors.grey),
                      ...widget.orderDetails.map((item) {
                        return Orderlist_Oder(item: item,puchaseoder_ttprice: widget.puchaseoder_ttprice);
                      }).toList(),
                      if (widget.pco_detail != null && widget.pco_detail!.isNotEmpty)
                        Row(
                          children: [
                            Text('หมายเหตุ '),
                            Text(widget.pco_detail!),
                          ],
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("รวมคำสั่งซื้อ: ฿${widget.puchaseoder_ttprice}"),
                        ],
                      ),
                    ],
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child:
                        Divider(color: const Color(0xFFCFCECE), thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0), // ระยะห่างระหว่าง Divider กับข้อความ
                    child: Text(
                      "คุณอาจชอบสิ่งนี้",
                      style: TextStyle(
                          fontWeight: FontWeight.bold), // เพิ่มสไตล์ให้ข้อความ
                    ),
                  ),
                  Expanded(
                    child:
                        Divider(color: const Color(0xFFCFCECE), thickness: 1),
                  ),
                ],
              ),
              Main_Promostion()
            ],
          ),
        ),
      ),
    );
  }
}

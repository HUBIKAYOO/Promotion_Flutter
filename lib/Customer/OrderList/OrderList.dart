import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:upro/Customer/OrderList/OrderList_Oder.dart';
import 'package:upro/Customer/OrderList/OrderList_Payment.dart';
import 'package:upro/Customer/OrderList/OrderList_SumOder.dart';
import 'package:upro/Customer/OrderList/orderlist_address.dart';
import 'package:upro/Customer/OrderList/orderlist_bottombar.dart';
import 'package:upro/IP.dart';
import 'package:upro/SignIn/Login/UserID.dart';

class OrderList extends StatefulWidget {
  final List<dynamic> store;
  final Map<int, List<dynamic>> data;
  String? selectedMenuDetailName;
  bool? Basket;
  OrderList(
      {required this.store,
      required this.data,
      this.selectedMenuDetailName,
      this.Basket});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  Map<int, List<dynamic>> _oderStatus1 = {};
  String? _purchaseorderId;
  // สร้าง Map สำหรับ TextEditingController
  Map<int, TextEditingController> nameControllers = {};

  Map<int, int> totalSumOder = {};
  int totalSum = 0;

  @override
  Widget build(BuildContext context) {
    totalSum = 0;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(title: Text("ทำรายการ")),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget.store.map((stores) {
                int storesrId = int.parse(stores['storeId'].toString());
                List<dynamic> orderDetails = widget.data[storesrId] ?? [];
                List<dynamic> orderDetails1 = _oderStatus1[storesrId] ?? [];
                print('1 : $orderDetails');
                Map<String, dynamic> totalSetPromotionCount =
                    getTotalSetPromotionCount(orderDetails);
                Map<String, dynamic> totalSetPromotion = {};
                int total = 0;
                if (orderDetails1.isNotEmpty) {
                  totalSetPromotion = getTotalSetPromotionCount(orderDetails1);
                  total = totalSetPromotionCount['total'] +
                      totalSetPromotion['total'];

                  totalSumOder[stores['storeId']] =
                      totalSetPromotionCount['sumOder'] +
                          totalSetPromotion['sumOder'];
                } else {
                  total = totalSetPromotionCount['total'];
                  totalSumOder[stores['storeId']] =
                      totalSetPromotionCount['sumOder'];
                }
                totalSum += total;
                print('total : $total');

                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Orderlist_Address(
                        data: orderDetails.isNotEmpty ? orderDetails[0] : {},
                      ),
                      SizedBox(height: 10),
                      Text("รายการ"),
                      ...orderDetails.map((storesrId) {
                        return Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              Orderlist_Oder(
                                  item: storesrId,
                                  selectedMenuDetailName:
                                      widget.selectedMenuDetailName)
                            ],
                          ),
                        );
                      }).toList(),
                      Orderlist_Sumoder(
                        total: totalSetPromotionCount['total'],
                        sumOder: totalSetPromotionCount['sumOder'],
                      ),
                      if (_oderStatus1.containsKey(storesrId))
                        Opacity(
                          opacity: 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text("ค่างชำระ"),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    SizedBox(height: 5),
                                    ..._oderStatus1[stores['storeId']]!
                                        .map((item) {
                                      return Orderlist_Oder(item: item);
                                    }).toList(),
                                  ],
                                ),
                              ),
                              Orderlist_Sumoder(
                                total: totalSetPromotion['total'],
                                sumOder: totalSetPromotion['sumOder'],
                              ),
                            ],
                          ),
                        ),
                      if (_oderStatus1.containsKey(storesrId)) ...[
                        SizedBox(height: 10),
                        Orderlist_Sumoder(
                          sumtotal: total,
                          sumsumOder: totalSumOder[stores['storeId']],
                        ),
                      ],
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("หมายเหตุ"),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xFFEEEEEE)),
                              child: TextField(
                                controller: nameControllers[storesrId],
                                decoration: InputDecoration(
                                  hintText: "รายละเอียดเพิ่มเติม",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
              Orderlist_Payment(
                  totalSum: totalSum,
                  sumOder: totalSumOder.values.reduce((a, b) => a + b)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: OrderList_Bottombar(
          data: widget.data,
          sumOder: totalSumOder,
          purchaseorderId: _purchaseorderId,
          selectedMenuDetailName: widget.selectedMenuDetailName,
          Basket: widget.Basket ?? false,
          nameControllers: nameControllers),
    );
  }

  Map<String, dynamic> getTotalSetPromotionCount(List<dynamic> orderDetails) {
    int total = 0;
    int sumOder = 0;
    for (var detail in orderDetails) {
      if (detail is Map<String, dynamic>) {
        int count = detail['repeated'];
        int sumOders = detail['price'];
        sumOders = sumOders * count;
        if (count != null) {
          total += count;
          sumOder += sumOders;
        }
      }
    }
    return {'total': total, 'sumOder': sumOder};
  }

  @override
  void initState() {
    super.initState();
    for (var store in widget.store) {
      int storeId = int.parse(store['storeId'].toString());
      nameControllers[storeId] = TextEditingController(); // สร้าง TextEditingController ที่นี่
    }
    _fetchAttractions(widget.store);
  }

  Future<void> _fetchAttractions(List<dynamic> storeId) async {
    try {
      Map<int, List<dynamic>> _oderStatus = {};
      final userId = Provider.of<UserIdProvider>(context, listen: false).userId;

      // หาใบสั่งซื้อที่ยังไม่ชำระ
      for (var storeID in storeId) {
        int ID = storeID['storeId'];
        // print('ID : $ID');
        final response = await http.get(Uri.parse(
            'http://$IP/puchaseoder/store/$ID/status/1/user/$userId'));

        if (response.statusCode == 200) {
          List<dynamic> _data = json.decode(response.body);
          // print('_data : $_data');
          Map<String, dynamic> firstItem = _data[0];
          print('firstItem : $firstItem');
          String purchaseorderId = firstItem['puchaseoder_id'].toString();

          // หา oder ที่ยังไม่ได้ชำระเงิน
          final response1 = await http.get(
              Uri.parse('http://$IP/orders/puchaseorder/$purchaseorderId'));

          if (response1.statusCode == 200) {
            List<dynamic> oderStatus1 = json.decode(response1.body);
            print('oderStatus1 : $oderStatus1');
            setState(() {
              _oderStatus1[ID] = oderStatus1;
              nameControllers[ID] =
                  TextEditingController(text: firstItem['pco_detail']);
            });
          } else {
            throw Exception('Error fetching orders');
          }
        } else {
          throw Exception('Error fetching purchase order');
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error: $e');
    }
  }
}

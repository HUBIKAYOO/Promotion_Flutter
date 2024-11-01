import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:upro/Customer/OrderList/OrderList_Oder.dart';
import 'package:upro/Customer/PurchaseOrder/PurchaseOrder_List_Store.dart';
import 'package:upro/Customer/PurchaseOrder/PurchaseOrder_List_Totol.dart';
import 'package:upro/IP.dart';
import 'package:upro/SignIn/Login/UserID.dart';

class PurchaseOrder_List extends StatefulWidget {
  final String POStatus;
  final Function(String)? onStatusUpdated; // เพิ่ม callback function

  PurchaseOrder_List({
    required this.POStatus,
    this.onStatusUpdated, // รับค่า callback
  });

  @override
  State<PurchaseOrder_List> createState() => _PurchaseOrder_ListState();
}

class _PurchaseOrder_ListState extends State<PurchaseOrder_List> {
  List<dynamic> _purchaseOrders = [];
  Map<int, List<dynamic>> _orderDetailsMap = {};

  @override
  void initState() {
    super.initState();
    _fetchPurchaseOrders();
  }

  Future<void> _fetchPurchaseOrders() async {
    final userId = Provider.of<UserIdProvider>(context, listen: false).userId;

    try {
      final response = await http.get(Uri.parse(
          'http://$IP/puchaseoder/user/$userId/status/${widget.POStatus}'));

      if (response.statusCode == 200) {
        setState(() {
          _purchaseOrders = json.decode(response.body);
        });

        // Fetch order details for each purchase order
        for (var order in _purchaseOrders) {
          int purchaseOrderId = int.parse(order['puchaseoder_id'].toString());
          await _fetchOrderDetails(purchaseOrderId);
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _fetchOrderDetails(int puchaseoderId) async {
    try {
      final response = await http
          .get(Uri.parse('http://$IP/orders/puchaseorder/$puchaseoderId'));

      if (response.statusCode == 200) {
        final details = json.decode(response.body);
        setState(() {
          if (_orderDetailsMap.containsKey(puchaseoderId)) {
            _orderDetailsMap[puchaseoderId]!.addAll(details);
          } else {
            _orderDetailsMap[puchaseoderId] = details;
          }
        });
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (e) {
      print('Error fetching order details: $e');
    }
  }

  // ฟังก์ชันเรียกใช้งาน callback เมื่อมีการเปลี่ยนสถานะ
  void _handleStatusChange(String newStatus) {
    if (widget.onStatusUpdated != null) {
      widget.onStatusUpdated!(newStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("_purchaseOrders : $_purchaseOrders");
    print("_orderDetailsMap : $_orderDetailsMap");

    return Container(
      margin: EdgeInsets.all(10),
      color: Color(0xFFEEEEEE),
      child: Column(
        children: _purchaseOrders.isEmpty
            ? [Center(child: Text('ไม่มีข้อมูล'))]
            : _purchaseOrders.map((purchase) {
                int puchaseoderId =
                    int.parse(purchase['puchaseoder_id'].toString());
                List<dynamic> orderDetails =
                    _orderDetailsMap[puchaseoderId] ?? [];
                int totalRepeated = 0;

                for (var item in orderDetails) {
                  if (item['repeated'] != null) {
                    totalRepeated += int.parse(item['repeated'].toString());
                  }
                }

                String puoderStatusId = purchase['puoder_status_id'].toString();

                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PurchaseOrder_List_Store(
                        storesrId:purchase['storeId'],
                        pco_detail:purchase['pco_detail'],
                          storeName: purchase['storeName'],
                          orderDetails: orderDetails,
                          puchaseoder_ttprice: double.parse(
                              purchase['puchaseoder_ttprice'].toString())),
                      SizedBox(height: 1),
                      Divider(color: Colors.grey),
                      ...orderDetails.map((item) {
                        return Orderlist_Oder(item: item,puchaseoder_ttprice: double.parse(
                              purchase['puchaseoder_ttprice'].toString()));
                      }).toList(),
                      PurchaseOrder_List_Totol(
                        totalRepeated: totalRepeated,
                        puoderStatusId: puoderStatusId,
                        puchaseoder_id: purchase['puchaseoder_id'],
                        amount: double.parse(
                            purchase['puchaseoder_ttprice'].toString()),
                        onStatusUpdated:
                            _handleStatusChange, // เรียก callback เมื่อมีการเปลี่ยนสถานะ
                      ),
                    ],
                  ),
                );
              }).toList(),
      ),
    );
  }
}

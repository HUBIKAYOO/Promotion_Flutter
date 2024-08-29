import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:upro/Customer/PurchaseOrder/PurchaseOrder_List_Store.dart';
import 'package:upro/Customer/PurchaseOrder/PurchaseOrder_List_Totol.dart';
import 'package:upro/Customer/PurchaseOrder/PurchaseOrder_List_Oder.dart';
import 'package:upro/IP.dart';
import 'package:upro/SignIn/Login/UserID.dart';

class PurchaseOrder_List extends StatefulWidget {
  final String POStatus;
  PurchaseOrder_List({required this.POStatus});

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

  @override
  Widget build(BuildContext context) {
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
                print(orderDetails);
                print('QQQQQQQQQQQQQQQQQQQQQQ');

                String puoderStatusId = purchase['puoder_status_id'].toString();

                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PurchaseOrder_List_Store(
                        storeName: purchase['storeName'],orderDetails: orderDetails
                      ),
                      SizedBox(height: 1),
                      Divider(color: Colors.grey),
                      PurchaseOrder_List_Oder(orderDetails: orderDetails),
                      PurchaseOrder_List_Totol(
                        puoderStatusId: puoderStatusId,
                      ),
                    ],
                  ),
                );
              }).toList(),
      ),
    );
  }
}

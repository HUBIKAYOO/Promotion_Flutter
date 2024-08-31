import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upro/Customer/OrderList/OrderList_Oder.dart';
import 'package:upro/Customer/OrderList/OrderList_Payment.dart';
import 'package:upro/Customer/OrderList/orderlist_address.dart';
import 'package:upro/Customer/OrderList/orderlist_bottombar.dart';
import 'package:upro/IP.dart';
import 'package:upro/SignIn/Login/UserID.dart';

class OrderList extends StatefulWidget {
  final Map<String, dynamic> data;
  Set<int>? selectedIds;
  OrderList({required this.data, this.selectedIds});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  void initState() {
    super.initState();
    _fetchAttractions();
  }

  List<dynamic>? _oderStatus1;
  String? _purchaseorderId;
  double? _sumOder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ทำรายการ"),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.amberAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Orderlist_Address(data: widget.data),
            Orderlist_Oder(
                data: widget.data,
                oderStatus1:
                    _oderStatus1), // ส่งค่า _oderStatus1 ไปยัง Orderlist_Oder
            Orderlist_Payment(data: widget.data)
          ],
        ),
      ),
      bottomNavigationBar: OrderList_Bottombar(
          data: widget.data,
          sumOder: _sumOder,
          purchaseorderId: _purchaseorderId),
    );
  }

  Future<void> _fetchAttractions() async {
    try {
      final userId = Provider.of<UserIdProvider>(context, listen: false).userId;

      //หาใบสั่งซื่อที่ยังไม่ไม่ได้ชำระ
      final response = await http.get(Uri.parse(
          'http://$IP/puchaseoder/store/${widget.data['storeId']}/status/1/user/$userId'));
      print('Response: $response');

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        Map<String, dynamic> firstItem = data[0];
        String purchaseorderId = firstItem['puchaseoder_id'].toString();
        print('Purchase Order ID: $purchaseorderId');

        //หาoderที่ยังไม่ได้ชำระเงิน
        final response1 = await http
            .get(Uri.parse('http://$IP/orders/puchaseorder/$purchaseorderId'));

        if (response1.statusCode == 200) {
          List<dynamic> oderStatus1 = json.decode(response1.body);

          //เอาoderมารวม
          final response2 = await http
              .get(Uri.parse('http://$IP/sum-prices/$purchaseorderId'));
          if (response2.statusCode == 200) {
            var responseBody = json.decode(response2.body);
            double result = (responseBody[0]['total_price'] as num).toDouble() +
                (widget.data['price'] as num).toDouble();
            setState(() {
              _oderStatus1 = oderStatus1;
              _purchaseorderId = purchaseorderId;
              _sumOder = result;
            });
          }
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:upro/Customer/promostion/Promostion_Bottombar.dart';
import 'package:upro/Customer/main/main_promotion.dart';
import 'package:upro/Customer/promostion/promostion_image.dart';
import 'package:upro/Customer/promostion/promostion_map.dart';

class Promostion extends StatefulWidget {
  final dynamic data;

  // คอนสตรัคเตอร์ที่รับข้อมูล
  Promostion({required this.data});

  @override
  _PromostionState createState() => _PromostionState();
}

class _PromostionState extends State<Promostion> {
  late Map<String, dynamic> _data;

  @override
  void initState() {
    super.initState();
    // ตั้งค่าเริ่มต้นของข้อมูล
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    print(_data);
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Promostion_Bottombar(data: _data),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              children: [
                Promostion_Image(data: _data),
                SizedBox(height: 10),
                _Location(_data),
                SizedBox(height: 10),
                _Details(),
                Main_Promostion(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_Location(_data) => Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.location_on,color: Colors.orange,),
            SizedBox(
              width: 5,
            ),
            Text(
              "ที่อยู่ร้านค้า",
              style: TextStyle(fontSize: 15),
            ),
          ]),
          Padding(
              padding: EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 5),
              child: Promostion_Map()),
          Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text('${_data['storeName']} ต.ปากู จ.ปัตตานี 95000')),
        ],
      ),
    );

_Details() => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text("คุณลักษณะ")),
          Divider(color: Colors.grey),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("a;evksmrtokbmt")),
          Divider(color: Colors.grey),
          Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Center(child: Text("เพิ่มชึ้น v")))
        ],
      ),
    );
